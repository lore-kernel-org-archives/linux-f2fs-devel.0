From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH -next] f2fs: remove set but not used variable 'err'
Date: Fri, 4 Jan 2019 10:37:23 +0800
Message-ID: <e879debb-e000-3f97-9b99-e7e84d167903@huawei.com>
References: <1546565909-17400-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546565909-17400-1-git-send-email-yuehaibing@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/1/4 9:38, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> fs/f2fs/data.c: In function 'f2fs_dio_submit_bio':
> fs/f2fs/data.c:2585:6: warning:
>  variable 'err' set but not used [-Wunused-but-set-variable]
> 
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
