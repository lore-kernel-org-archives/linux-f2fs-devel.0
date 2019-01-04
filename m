From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: wait on atomic writes to count
 F2FS_CP_WB_DATA
Date: Fri, 4 Jan 2019 12:36:04 -0800
Message-ID: <20190104203604.GC57873@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190104042025.31982-1-jaegeuk@kernel.org>
 <3e50bcd6-1730-c28d-2d28-7a8e57f456cf@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3e50bcd6-1730-c28d-2d28-7a8e57f456cf@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 01/04, Chao Yu wrote:
> On 2019/1/4 12:20, Jaegeuk Kim wrote:
> > Otherwise, we can get wrong counts incurring checkpoint hang.
> > 
> > IO_W (CP:  -24, Data:   24, Flush: (   0    0    1), Discard: (   0    0))
> > 
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Good catch! ;)
> 
> I can understand this condition, but for other new developer who reads this
> commit, it will be a little hard to understand situation here.
> 
> How about explaining a little more about problem here, maybe:
> 
> Thread A			Thread B		
> - f2fs_write_data_pages
>  -  __write_data_page
>   - f2fs_submit_page_write
>    - inc_page_count(F2FS_WB_DATA)
>      type is F2FS_WB_DATA due to file is non-atomic one
> - f2fs_ioc_start_atomic_write
>  - set_inode_flag(FI_ATOMIC_FILE)
> 				- f2fs_write_end_io
> 				 - dec_page_count(F2FS_WB_CP_DATA)
> 				   type is F2FS_WB_DATA due to file becomes
> 				   atomic one
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks, added the comment. :P

> 
> Thanks,
> 
