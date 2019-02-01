From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 5/7] f2fs: avoid null pointer exception in
 dcc_info
Date: Sat, 2 Feb 2019 00:00:35 +0800
Message-ID: <d3da8cd4-e026-e619-fd57-f3c029a9ee5b@kernel.org>
References: <20190128234717.77225-1-jaegeuk@kernel.org>
 <20190128234717.77225-5-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128234717.77225-5-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019-1-29 7:47, Jaegeuk Kim wrote:
> If dcc_info is not set yet, we can get null pointer panic.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
