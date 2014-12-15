From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev][PATCH] f2fs: merge two uchar variable in struct
 nat_entry to reduce memory cost
Date: Mon, 15 Dec 2014 17:16:36 +0800
Message-ID: <002401d01848$010fa9a0$032efce0$@samsung.com>
References: <001c01d012b6$a0fbaaa0$e2f2ffe0$@samsung.com>
 <20141215082717.GA83773@jaegeuk-mac02.mot-mobility.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <20141215082717.GA83773@jaegeuk-mac02.mot-mobility.com>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Monday, December 15, 2014 4:27 PM
> To: Chao Yu
> Cc: Changman Lee; linux-f2fs-devel@lists.sourceforge.net; linux-fsdevel@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [f2fs-dev][PATCH] f2fs: merge two uchar variable in struct nat_entry to reduce
> memory cost
> 
> Hi Chao,
> 
> I found a bug in this patch.

Oh, it's my bad. I will fix this as you suggested.
Thank you for helping to find this bug. :)

Regards,
Yu

> 
> In set_node_addr,
> 
>  	down_write(&nm_i->nat_tree_lock);
> 	e = __lookup_nat_cache(nm_i, ni->nid);
> 	if (!e) {
> 		e = grab_nat_entry(nm_i, ni->nid);
> 		e->ni = *ni;
> 		^^^^^^^^^^^^
> 		this line should not copy ni.flag.
> 
> 		f2fs_bug_on(sbi, ni->blk_addr == NEW_ADDR);
> 	} else if (new_blkaddr == NEW_ADDR) {
> 		/*
> 		 * when nid is reallocated,
> 		 * previous nat entry can be remained in nat cache.
> 		 * So, reinitialize it with new information.
> 		 */
> 		e->ni = *ni;
> 		^^^^^^^^^^^^
> 		ditto.
> 
> 		f2fs_bug_on(sbi, ni->blk_addr != NULL_ADDR);
> 	}
> 
> So, please add inline function in node.h like:
> 
> static inline void copy_node_info(dst, src)
> {
> 	dst->nid = src->nid;
> 	dst->ino = src->ino;
> 	dst->blk_addr = src->blk_addr;
> 	dst->version = src->version;
> 	/* should not copy flag here */
> }
> 
> Then let's use this function.
> 
> Thanks,
> 

