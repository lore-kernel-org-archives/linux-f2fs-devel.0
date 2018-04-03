From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: truncate preallocated blocks in error case
Date: Tue, 3 Apr 2018 10:40:36 +0800
Message-ID: <62b2179c-655c-8246-6321-7ac8e5ea089e@huawei.com>
References: <20180331015710.72893-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180331015710.72893-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/3/31 9:57, Jaegeuk Kim wrote:
> If write is failed, we must deallocate the blocks that we couldn't write.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
