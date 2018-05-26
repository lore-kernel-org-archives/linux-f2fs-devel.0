From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] f2fs: Fix deadlock in shutdown ioctl
Date: Sat, 26 May 2018 08:37:11 +0800
Message-ID: <64178374-e67c-36a7-62a0-22c4e8ff9358@huawei.com>
References: <1526624512-32241-1-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526624512-32241-1-git-send-email-stummala@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/5/18 14:21, Sahitya Tummala wrote:
> f2fs_ioc_shutdown() ioctl gets stuck in the below path
> when issued with F2FS_GOING_DOWN_FULLSYNC option.
> 
> __switch_to+0x90/0xc4
> percpu_down_write+0x8c/0xc0
> freeze_super+0xec/0x1e4
> freeze_bdev+0xc4/0xcc
> f2fs_ioctl+0xc0c/0x1ce0
> f2fs_compat_ioctl+0x98/0x1f0
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
