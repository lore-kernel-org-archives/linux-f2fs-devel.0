From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/7] f2fs: avoid needless lock for node pages
 when fsyncing a file
Date: Tue, 26 Apr 2016 20:51:04 +0800
Message-ID: <d9af7096-871c-9686-4221-e43c32bf6d10@huawei.com>
References: <1461629220-16280-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1461629220-16280-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: chenhao36@huawei.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2016/4/26 8:06, Jaegeuk Kim wrote:
> When fsync is called, sync_node_pages finds a proper direct node pages to flush.
> But, it locks unrelated direct node pages together unnecessarily.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

I've reviewed this patchset, it looks good to me, please add:

Acked-by: Chao Yu <yuchao0@huawei.com>

