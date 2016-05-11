From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/6] f2fs: support in batch multi blocks preallocation
Date: Wed, 11 May 2016 10:22:05 +0800
Message-ID: <705bb492-b510-462e-fef3-d2f66dbb871f@huawei.com>
References: <20160509115635.123946-1-yuchao0@huawei.com>
 <20160509230037.GA6889@jaegeuk.gateway>
 <bcf5439c-88a3-8669-0bc0-6111249e1f27@huawei.com>
 <20160510214125.GA9867@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160510214125.GA9867@jaegeuk.gateway>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2016/5/11 5:41, Jaegeuk Kim wrote:
> +
> +	f2fs_wait_on_page_writeback(dn->node_page, NODE, true);
> +
> +	for (; count > 0; dn->ofs_in_node++) {
> +		block_t blkaddr =
> +			datablock_addr(dn->node_page, dn->ofs_in_node);
> +		if (blkaddr == NULL_ADDR) {
> +			dn->data_blkaddr = NEW_ADDR;
> +			__set_data_blkaddr(dn);
> +			count--;
> +		}
> +	}

Should let ofs_in_node increase to offset where blkaddr = NULL_ADDR in
ENOSPC case or increase to end_offset in normal case, right?

Thanks,
