From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 1/2] f2fs: keep PagePrivate during releasepage
Date: Thu, 05 Feb 2015 15:50:49 +0800
Message-ID: <005c01d04118$9042c5a0$b0c850e0$@samsung.com>
References: <1422917479-36393-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1422917479-36393-1-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, February 03, 2015 6:51 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 1/2] f2fs: keep PagePrivate during releasepage
> 
> If PagePrivate is removed by releasepage, f2fs loses counting dirty pages.
> 
> e.g., try_to_release_page will not release page when the page is dirty,
> but our releasepage removes PagePrivate.
> 
>     [<ffffffff81188d75>] try_to_release_page+0x35/0x50
>     [<ffffffff811996f9>] invalidate_inode_pages2_range+0x2f9/0x3b0
>     [<ffffffffa02a7f54>] ? truncate_blocks+0x384/0x4d0 [f2fs]
>     [<ffffffffa02b7583>] ? f2fs_direct_IO+0x283/0x290 [f2fs]
>     [<ffffffffa02b7fb0>] ? get_data_block_fiemap+0x20/0x20 [f2fs]
>     [<ffffffff8118aa53>] generic_file_direct_write+0x163/0x170
>     [<ffffffff8118ad06>] __generic_file_write_iter+0x2a6/0x350
>     [<ffffffff8118adef>] generic_file_write_iter+0x3f/0xb0
>     [<ffffffff81203081>] new_sync_write+0x81/0xb0
>     [<ffffffff81203837>] vfs_write+0xb7/0x1f0
>     [<ffffffff81204459>] SyS_write+0x49/0xb0
>     [<ffffffff817c286d>] system_call_fastpath+0x16/0x1b
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
