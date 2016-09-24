From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: use crc and cp version to determine
 roll-forward recovery
Date: Sat, 24 Sep 2016 11:20:11 -0700
Message-ID: <20160924182011.GC25123@jaegeuk>
References: <20160920025504.72524-1-jaegeuk@kernel.org>
 <6d5c6ce9-b9d6-badd-244a-b6126ce14546@kernel.org>
 <20160921004554.GB77057@jaegeuk>
 <64ec1af3-f9ca-77ce-9f99-3ceaee48e9f8@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <64ec1af3-f9ca-77ce-9f99-3ceaee48e9f8@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Sat, Sep 24, 2016 at 02:00:41PM +0800, Chao Yu wrote:
> On 2016/9/21 8:45, Jaegeuk Kim wrote:
> > @@ -259,40 +290,26 @@ static inline void fill_node_footer_blkaddr(struct page *page, block_t blkaddr)
> >  {
> >  	struct f2fs_checkpoint *ckpt = F2FS_CKPT(F2FS_P_SB(page));
> >  	struct f2fs_node *rn = F2FS_NODE(page);
> > +	size_t crc_offset = le32_to_cpu(ckpt->checksum_offset);
> > +	__u64 cp_ver = le64_to_cpu(ckpt->checkpoint_ver);
> > +	__u64 crc;
> >  
> > -	rn->footer.cp_ver = ckpt->checkpoint_ver;
> > +	crc = le32_to_cpu(*((__le32 *)((unsigned char *)ckpt + crc_offset)));
> > +	cp_ver |= (crc << 32);
> 
> How about using '^=' here?

The crc is already random enough, but has 32bits only.
The cp_ver is not easy to use over 32bits, so we don't need to keep the other
32bits untouched in most of life.

Thanks,

> 
> > +	rn->footer.cp_ver = cpu_to_le64(cp_ver);
> >  	rn->footer.next_blkaddr = cpu_to_le32(blkaddr);
> >  }
> >  
> > -static inline nid_t ino_of_node(struct page *node_page)
> > -{
> > -	struct f2fs_node *rn = F2FS_NODE(node_page);
> > -	return le32_to_cpu(rn->footer.ino);
> > -}
> > -
> > -static inline nid_t nid_of_node(struct page *node_page)
> > -{
> > -	struct f2fs_node *rn = F2FS_NODE(node_page);
> > -	return le32_to_cpu(rn->footer.nid);
> > -}
> > -
> > -static inline unsigned int ofs_of_node(struct page *node_page)
> > -{
> > -	struct f2fs_node *rn = F2FS_NODE(node_page);
> > -	unsigned flag = le32_to_cpu(rn->footer.flag);
> > -	return flag >> OFFSET_BIT_SHIFT;
> > -}
> > -
> > -static inline unsigned long long cpver_of_node(struct page *node_page)
> > +static inline bool is_recoverable_dnode(struct page *page)
> >  {
> > -	struct f2fs_node *rn = F2FS_NODE(node_page);
> > -	return le64_to_cpu(rn->footer.cp_ver);
> > -}
> > +	struct f2fs_checkpoint *ckpt = F2FS_CKPT(F2FS_P_SB(page));
> > +	size_t crc_offset = le32_to_cpu(ckpt->checksum_offset);
> > +	__u64 cp_ver = cur_cp_version(ckpt);
> > +	__u64 crc;
> >  
> > -static inline block_t next_blkaddr_of_node(struct page *node_page)
> > -{
> > -	struct f2fs_node *rn = F2FS_NODE(node_page);
> > -	return le32_to_cpu(rn->footer.next_blkaddr);
> > +	crc = le32_to_cpu(*((__le32 *)((unsigned char *)ckpt + crc_offset)));
> > +	cp_ver |= (crc << 32);
> > +	return cpu_to_le64(cp_ver) == cpver_of_node(page);
> >  }
> 
> cpu_to_le64(cp_ver) == cpver_of_node(page) ^ (crc << 32)
> 
> Thanks,
