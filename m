From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: add reserved blocks for root user
Date: Wed, 3 Jan 2018 14:46:27 +0800
Message-ID: <b91cc440-0401-9818-4e37-2ef6d6cf602a@huawei.com>
References: <20171228021919.29397-1-jaegeuk@kernel.org>
 <20180101012953.GA81647@jaegeuk-macbookpro.roam.corp.google.com>
 <3956a904-914e-6233-ab2c-c92db587537e@huawei.com>
 <20180102192456.GA474@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180102192456.GA474@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/1/3 3:24, Jaegeuk Kim wrote:
>> How about adding uid & gid verification also like ext4?
> 
> Again, that's another feature which requires a mount option. I think it'd be
> better to add that, once we have a use-case.

That's OK. ;)

Thanks,
