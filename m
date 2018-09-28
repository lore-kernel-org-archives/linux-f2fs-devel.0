From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: return correct errno in f2fs_gc
Date: Fri, 28 Sep 2018 18:45:41 +0800
Message-ID: <524fd9a6-886b-fbb1-6fd2-d5f8d39f42c5@huawei.com>
References: <20180926014617.12369-1-jaegeuk@kernel.org>
 <20180926014617.12369-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926014617.12369-2-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/9/26 9:46, Jaegeuk Kim wrote:
> This fixes overriding error number in f2fs_gc.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
