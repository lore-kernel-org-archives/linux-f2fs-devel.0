From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 4/7] f2fs: don't wake up too frequently, if
 there is lots of IOs
Date: Fri, 1 Feb 2019 23:58:55 +0800
Message-ID: <f02b925b-8d42-e22d-9a73-900089dbed6a@kernel.org>
References: <20190128234717.77225-1-jaegeuk@kernel.org>
 <20190128234717.77225-4-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128234717.77225-4-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019-1-29 7:47, Jaegeuk Kim wrote:
> Otherwise, it wakes up discard thread which will sleep again by busy IOs
> in a loop.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
