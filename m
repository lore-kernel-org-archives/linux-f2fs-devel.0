From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix missing unlock(sbi->gc_mutex)
Date: Wed, 19 Dec 2018 11:44:18 +0800
Message-ID: <eea9cea9-1df9-3768-15f0-48f7332212e6@huawei.com>
References: <20181218021530.78323-1-jaegeuk@kernel.org>
 <20181218232228.GE31062@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218232228.GE31062@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/12/19 7:22, Jaegeuk Kim wrote:
> This fixes missing unlock call.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Looks good to me now. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
