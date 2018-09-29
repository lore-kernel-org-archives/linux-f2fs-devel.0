From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix missing up_read
Date: Sat, 29 Sep 2018 10:05:09 +0800
Message-ID: <9865a464-11bc-f8ae-b11f-9bd2f7dd66ec@huawei.com>
References: <20180928174854.65978-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180928174854.65978-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/9/29 1:48, Jaegeuk Kim wrote:
> This patch fixes missing up_read call.

I guess we need to add additional type of error injection to simulate
on-disk blkaddr corruption, then we can cover all those error paths.

> 
> Fixes: c9b60788fc76 ("f2fs: fix to do sanity check with block address in main area")
> Cc: <stable@vger.kernel.org> # 4.19+
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
