From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3 1/2] f2fs: fix to allow node segment for GC by ioctl
 path
Date: Mon, 26 Nov 2018 17:59:55 +0800
Message-ID: <ecd179e0-798f-ceea-24e1-36f9bb56fe10@huawei.com>
References: <1543219302-12219-1-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543219302-12219-1-git-send-email-stummala@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/11/26 16:01, Sahitya Tummala wrote:
> Allow node type segments also to be GC'd via f2fs ioctl
> F2FS_IOC_GARBAGE_COLLECT_RANGE.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
