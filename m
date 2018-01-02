From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev v2] [PATCH 1/2] f2fs: stop checkpoint only from fault
 injection
Date: Tue, 2 Jan 2018 14:32:09 +0800
Message-ID: <46618bcd-c097-33f1-6296-c77dccb586e9@huawei.com>
References: <20171229020056.60558-1-jaegeuk@kernel.org>
 <665883a3-f065-e531-0730-c41b227df589@huawei.com>
 <20180101013106.GB81647@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180101013106.GB81647@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/1/1 9:31, Jaegeuk Kim wrote:
> We can give another chance to write user data, which can resolve
> generic/441.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
