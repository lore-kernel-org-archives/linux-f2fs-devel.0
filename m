From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: clear PageError on writepage
Date: Mon, 16 Apr 2018 09:52:45 +0800
Message-ID: <f1821d3a-8904-6142-61aa-c7e4fc0d4934@huawei.com>
References: <20180413010716.53610-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180413010716.53610-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/4/13 9:07, Jaegeuk Kim wrote:
> This patch clears PageError in some pages tagged by read path, but when we
> write the pages with valid contents, writepage should clear the bit likewise
> ext4.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
