From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid infinite loop in f2fs_alloc_nid
Date: Thu, 20 Sep 2018 14:09:04 +0800
Message-ID: <0a763635-d276-058c-5823-965a2ad09096@huawei.com>
References: <20180919224740.80917-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919224740.80917-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/9/20 6:47, Jaegeuk Kim wrote:
> If we have an error in f2fs_build_free_nids, we're able to fall into a loop
> to find free nids.
> 
> Suggested-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
