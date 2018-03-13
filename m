From: guoweichao <guoweichao@huawei.com>
Subject: Re: [PATCH v4] f2fs: support in-memory inode checksum
 when checking consistency
Date: Tue, 13 Mar 2018 17:19:51 +0800
Message-ID: <3a0789e6-1499-0538-0e08-b978f77a22f0@huawei.com>
References: <20180307211040.219117-1-guoweichao@huawei.com>
 <20180313084900.GA27687@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <guoweichao@huawei.com>) id 1evg6Z-0007oJ-Hn
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 13 Mar 2018 09:20:23 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1evg6W-009RUk-Qd
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 13 Mar 2018 09:20:23 +0000
In-Reply-To: <20180313084900.GA27687@codeaurora.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sahitya Tummala <stummala@codeaurora.org>
Cc: jaegeuk@kernel.org, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net



On 2018/3/13 16:49, Sahitya Tummala wrote:
> On Thu, Mar 08, 2018 at 05:10:40AM +0800, Weichao Guo wrote:
>> @@ -159,8 +162,12 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page)
>>  	struct f2fs_inode *ri;
>>  	__u32 provided, calculated;
>>  
>> +#ifdef CONFIG_F2FS_CHECK_FS
>> +	if (!f2fs_enable_inode_chksum(sbi, page))
>> +#else
>>  	if (!f2fs_enable_inode_chksum(sbi, page) ||
>>  			PageDirty(page) || PageWriteback(page))
> 
> I see that f2fs_inode_chksum_set() is set only if CONFIG_F2FS_CHECK_FS is
f2fs_inode_chksum_set is also called in allocate_data_block when fs write back inode to disk.
> enabled. So in this #else case, if sb has inode checksum enabled but
> PageDirty() or PageWriteback() is not set, then we may proceed below and do
So when the inode is read from disk, e.g. PageDirty / PageWriteback is not set,
the checksum verify process should be ok.
> the comparison between provided and calculated check sum and it may fail
> resulting into checksum invalid error?
> 
>> +#endif
>>  		return true;
>>  
>>  	ri = &F2FS_NODE(page)->i;
>> @@ -445,6 +452,9 @@ void update_inode(struct inode *inode, struct page *node_page)
>>  	if (inode->i_nlink == 0)
>>  		clear_inline_node(node_page);
>>  
>> +#ifdef CONFIG_F2FS_CHECK_FS
>> +	f2fs_inode_chksum_set(F2FS_I_SB(inode), node_page);
>> +#endif
>>  }
>>  
>>  void update_inode_page(struct inode *inode)
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index 177c438..2adeb74 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -1113,8 +1113,10 @@ static int read_node_page(struct page *page, int op_flags)
>>  		.encrypted_page = NULL,
>>  	};
>>  
>> -	if (PageUptodate(page))
>> +	if (PageUptodate(page)) {
>> +		f2fs_bug_on(sbi, !f2fs_inode_chksum_verify(sbi, page));
>>  		return LOCKED_PAGE;
>> +	}
>>  
>>  	get_node_info(sbi, page->index, &ni);
>>  
>> diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
>> index 081ef0d..b6015b7 100644
>> --- a/fs/f2fs/node.h
>> +++ b/fs/f2fs/node.h
>> @@ -278,6 +278,10 @@ static inline void fill_node_footer(struct page *page, nid_t nid,
>>  	/* should remain old flag bits such as COLD_BIT_SHIFT */
>>  	rn->footer.flag = cpu_to_le32((ofs << OFFSET_BIT_SHIFT) |
>>  					(old_flag & OFFSET_BIT_MASK));
>> +#ifdef CONFIG_F2FS_CHECK_FS
>> +	if (IN_INODE(page))
>> +		f2fs_inode_chksum_set(F2FS_P_SB(page), page);
>> +#endif
>>  }
>>  
>>  static inline void copy_node_footer(struct page *dst, struct page *src)
>> @@ -285,6 +289,10 @@ static inline void copy_node_footer(struct page *dst, struct page *src)
>>  	struct f2fs_node *src_rn = F2FS_NODE(src);
>>  	struct f2fs_node *dst_rn = F2FS_NODE(dst);
>>  	memcpy(&dst_rn->footer, &src_rn->footer, sizeof(struct node_footer));
>> +#ifdef CONFIG_F2FS_CHECK_FS
>> +	if (IN_INODE(dst))
>> +		f2fs_inode_chksum_set(F2FS_P_SB(dst), dst);
>> +#endif
>>  }
>>  
>>  static inline void fill_node_footer_blkaddr(struct page *page, block_t blkaddr)
>> @@ -298,6 +306,10 @@ static inline void fill_node_footer_blkaddr(struct page *page, block_t blkaddr)
>>  
>>  	rn->footer.cp_ver = cpu_to_le64(cp_ver);
>>  	rn->footer.next_blkaddr = cpu_to_le32(blkaddr);
>> +#ifdef CONFIG_F2FS_CHECK_FS
>> +	if (IN_INODE(page))
>> +		f2fs_inode_chksum_set(F2FS_P_SB(page), page);
>> +#endif
>>  }
>>  
>>  static inline bool is_recoverable_dnode(struct page *page)
>> @@ -364,6 +376,10 @@ static inline int set_nid(struct page *p, int off, nid_t nid, bool i)
>>  		rn->i.i_nid[off - NODE_DIR1_BLOCK] = cpu_to_le32(nid);
>>  	else
>>  		rn->in.nid[off] = cpu_to_le32(nid);
>> +#ifdef CONFIG_F2FS_CHECK_FS
>> +	if (IN_INODE(p))
>> +		f2fs_inode_chksum_set(F2FS_P_SB(p), p);
>> +#endif
>>  	return set_page_dirty(p);
>>  }
>>  
>> @@ -432,6 +448,10 @@ static inline void set_cold_node(struct inode *inode, struct page *page)
>>  	else
>>  		flag |= (0x1 << COLD_BIT_SHIFT);
>>  	rn->footer.flag = cpu_to_le32(flag);
>> +#ifdef CONFIG_F2FS_CHECK_FS
>> +	if (IN_INODE(page))
>> +		f2fs_inode_chksum_set(F2FS_I_SB(inode), page);
>> +#endif
>>  }
>>  
>>  static inline void set_mark(struct page *page, int mark, int type)
>> @@ -443,6 +463,10 @@ static inline void set_mark(struct page *page, int mark, int type)
>>  	else
>>  		flag &= ~(0x1 << type);
>>  	rn->footer.flag = cpu_to_le32(flag);
>> +#ifdef CONFIG_F2FS_CHECK_FS
>> +	if (IN_INODE(page))
>> +		f2fs_inode_chksum_set(F2FS_P_SB(page), page);
>> +#endif
>>  }
>>  #define set_dentry_mark(page, mark)	set_mark(page, mark, DENT_BIT_SHIFT)
>>  #define set_fsync_mark(page, mark)	set_mark(page, mark, FSYNC_BIT_SHIFT)
>> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
>> index ae2dfa7..572bc17 100644
>> --- a/fs/f2fs/xattr.c
>> +++ b/fs/f2fs/xattr.c
>> @@ -424,6 +424,9 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
>>  				return err;
>>  			}
>>  			memcpy(inline_addr, txattr_addr, inline_size);
>> +#ifdef CONFIG_F2FS_CHECK_FS
>> +			f2fs_inode_chksum_set(sbi, ipage ? ipage : in_page);
>> +#endif
>>  			set_page_dirty(ipage ? ipage : in_page);
>>  			goto in_page_out;
>>  		}
>> -- 
>> 2.10.1
>>
>>
>> ------------------------------------------------------------------------------
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
