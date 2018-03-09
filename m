From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] f2fs: add nowait aio support
Date: Fri, 9 Mar 2018 09:11:48 +0800
Message-ID: <0ca9e2b7-eb63-65f3-ee70-a8cf5b90debf@huawei.com>
References: <1520505278-24735-1-git-send-email-hyc.lee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520505278-24735-1-git-send-email-hyc.lee@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hyunchul Lee <hyc.lee@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-team@lge.com, Christoph Hellwig <hch@lst.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>, Hyunchul Lee <cheol.lee@lge.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/3/8 18:34, Hyunchul Lee wrote:
> From: Hyunchul Lee <cheol.lee@lge.com>
> 
> This patch adds nowait aio support[1].
> 
> Return EAGAIN if any of the following checks fail for direct I/O:
>   - i_rwsem is not lockable
>   - Blocks are not allocated at the write location
> 
> And xfstests generic/471 is passed.
> 
>  [1]: 6be96d "Introduce RWF_NOWAIT and FMODE_AIO_NOWAIT"
> 
> Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
