From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: use crc and cp version to
 determine roll-forward recovery
Date: Sat, 24 Sep 2016 14:00:41 +0800
Message-ID: <64ec1af3-f9ca-77ce-9f99-3ceaee48e9f8@huawei.com>
References: <20160920025504.72524-1-jaegeuk@kernel.org>
	<6d5c6ce9-b9d6-badd-244a-b6126ce14546@kernel.org>
	<20160921004554.GB77057@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1bng1X-0002iL-Ry
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Sep 2016 06:01:19 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bng1R-0005I6-Vo
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Sep 2016 06:01:19 +0000
In-Reply-To: <20160921004554.GB77057@jaegeuk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/9/21 8:45, Jaegeuk Kim wrote:
> @@ -259,40 +290,26 @@ static inline void fill_node_footer_blkaddr(struct page *page, block_t blkaddr)
>  {
>  	struct f2fs_checkpoint *ckpt = F2FS_CKPT(F2FS_P_SB(page));
>  	struct f2fs_node *rn = F2FS_NODE(page);
> +	size_t crc_offset = le32_to_cpu(ckpt->checksum_offset);
> +	__u64 cp_ver = le64_to_cpu(ckpt->checkpoint_ver);
> +	__u64 crc;
>  
> -	rn->footer.cp_ver = ckpt->checkpoint_ver;
> +	crc = le32_to_cpu(*((__le32 *)((unsigned char *)ckpt + crc_offset)));
> +	cp_ver |= (crc << 32);

How about using '^=' here?

> +	rn->footer.cp_ver = cpu_to_le64(cp_ver);
>  	rn->footer.next_blkaddr = cpu_to_le32(blkaddr);
>  }
>  
> -static inline nid_t ino_of_node(struct page *node_page)
> -{
> -	struct f2fs_node *rn = F2FS_NODE(node_page);
> -	return le32_to_cpu(rn->footer.ino);
> -}
> -
> -static inline nid_t nid_of_node(struct page *node_page)
> -{
> -	struct f2fs_node *rn = F2FS_NODE(node_page);
> -	return le32_to_cpu(rn->footer.nid);
> -}
> -
> -static inline unsigned int ofs_of_node(struct page *node_page)
> -{
> -	struct f2fs_node *rn = F2FS_NODE(node_page);
> -	unsigned flag = le32_to_cpu(rn->footer.flag);
> -	return flag >> OFFSET_BIT_SHIFT;
> -}
> -
> -static inline unsigned long long cpver_of_node(struct page *node_page)
> +static inline bool is_recoverable_dnode(struct page *page)
>  {
> -	struct f2fs_node *rn = F2FS_NODE(node_page);
> -	return le64_to_cpu(rn->footer.cp_ver);
> -}
> +	struct f2fs_checkpoint *ckpt = F2FS_CKPT(F2FS_P_SB(page));
> +	size_t crc_offset = le32_to_cpu(ckpt->checksum_offset);
> +	__u64 cp_ver = cur_cp_version(ckpt);
> +	__u64 crc;
>  
> -static inline block_t next_blkaddr_of_node(struct page *node_page)
> -{
> -	struct f2fs_node *rn = F2FS_NODE(node_page);
> -	return le32_to_cpu(rn->footer.next_blkaddr);
> +	crc = le32_to_cpu(*((__le32 *)((unsigned char *)ckpt + crc_offset)));
> +	cp_ver |= (crc << 32);
> +	return cpu_to_le64(cp_ver) == cpver_of_node(page);
>  }

cpu_to_le64(cp_ver) == cpver_of_node(page) ^ (crc << 32)

Thanks,


------------------------------------------------------------------------------
