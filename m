From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: apply write hints to select the type of segment
 for direct write
Date: Thu, 30 Nov 2017 14:20:35 +0800
Message-ID: <84c521a5-15a4-eda7-062e-0fed0dd0ab49@huawei.com>
References: <1511828580-574-1-git-send-email-hyc.lee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1511828580-574-1-git-send-email-hyc.lee@gmail.com>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Hyunchul Lee <hyc.lee@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@lge.com, Jens Axboe <axboe@kernel.dk>, Hyunchul Lee <cheol.lee@lge.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/11/28 8:23, Hyunchul Lee wrote:
> From: Hyunchul Lee <cheol.lee@lge.com>
> 
> When blocks are allocated for direct write, select the type of
> segment using the kiocb hint. But if an inode has FI_NO_ALLOC,
> use the inode hint.
> 
> Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
