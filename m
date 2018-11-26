From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3 2/2] f2fs: adjust trace print in f2fs_get_victim() to
 cover all paths
Date: Mon, 26 Nov 2018 18:00:23 +0800
Message-ID: <e0cf984c-a87b-ca7d-71f1-49f1dcbab3c7@huawei.com>
References: <1543219302-12219-1-git-send-email-stummala@codeaurora.org>
 <1543219302-12219-2-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543219302-12219-2-git-send-email-stummala@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/11/26 16:01, Sahitya Tummala wrote:
> Adjust the trace print in f2fs_get_victim() to cover GC done by
> F2FS_IOC_GARBAGE_COLLECT_RANGE.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
