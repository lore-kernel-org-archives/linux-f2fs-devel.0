From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: assign REQ_RAHEAD to bio for ->readpages
Date: Fri, 22 Jun 2018 15:38:41 +0800
Message-ID: <ce9fb180-2458-4c50-9cee-cfe1bfc3a201@huawei.com>
References: <20180621193213.86850-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621193213.86850-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jens Axboe <axboe@kernel.dk>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/6/22 3:32, Jaegeuk Kim wrote:
> As Jens reported, we'd better assign REQ_RAHEAD to bio by the fact that
> ->readpages is called only from read-ahead.
> 
> In Documentation/filesystems/vfs.txt,
> 
> readpages: called by the VM to read pages associated with the address_space
>   	object. This is essentially just a vector version of
>   	readpage.  Instead of just one page, several pages are
>   	requested.
> 	readpages is only used for read-ahead, so read errors are
>   	ignored.  If anything goes wrong, feel free to give up.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
