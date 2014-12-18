From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH v2] f2fs: use ra_meta_pages to simplify
 readahead code in restore_node_summary
Date: Thu, 18 Dec 2014 17:26:03 +0800
Message-ID: <005101d01aa4$c1974760$44c5d620$@samsung.com>
References: <001d01d019e1$d6ad6c10$84084430$@samsung.com>
 <CAN863PuF-aSNGxe6=5k9LL-9V5maHnNnd7w-Sz2GQPFz-MHC7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAN863PuF-aSNGxe6=5k9LL-9V5maHnNnd7w-Sz2GQPFz-MHC7A@mail.gmail.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Changman Lee' <cm224.lee@gmail.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Changman,

> -----Original Message-----
> From: Changman Lee [mailto:cm224.lee@gmail.com]
> Sent: Wednesday, December 17, 2014 11:20 PM
> To: Chao Yu
> Cc: Jaegeuk Kim; Changman Lee; linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH v2] f2fs: use ra_meta_pages to simplify readahead code in
> restore_node_summary
> 
> Hi,
> 
> Is there any reason to use truncate_inode_pages_range instead of
> invalidate_mapping_pages?
> IMHO, it seems nice to just use invalidate_mapping_pages because pages
> of meta_inode shouldn't be dirty, locked, under writeback or mapped in
> this function.
> If there is my misunderstanding, let me know.

I think you're right, I use truncate_inode_pages_range because just following the
usage of readahead-invalidate pair in recovery flow, but without considering the
difference between them.

I will fix this as you suggested.

> 
> Thanks,
> 
> Reviewed-by: Changman Lee <cm224.lee@samsung.com>

And thanks for your review! :)

Regards,
Yu
