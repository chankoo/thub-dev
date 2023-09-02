from pathlib import Path
from typing import Dict, List, Optional

from llama_index.readers.schema.base import Document
from llama_hub.file.cjk_pdf.base import CJKPDFReader


class EcoCJKPDFReader(CJKPDFReader):
    def load_data(
        self, file: Path, extra_info: Optional[Dict] = None
    ) -> List[Document]:
        """Parse file."""

        text_list = self._extract_text_by_page(file)

        if self._concat_pages:
            return [Document(text="\n".join(text_list), extra_info=extra_info or {})]
        else:
            return [
                Document(text=text, extra_info=extra_info or {"page_label": i}) for i, text in enumerate(text_list, 1)
            ]
