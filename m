From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid wrong decrypted data from disk
Date: Thu, 30 Aug 2018 23:44:48 +0800
Message-ID: <73a30772-98f3-620b-720e-2121da85abec@kernel.org>
References: <20180827225226.14272-1-jaegeuk@kernel.org>
 <20180830014858.GA91444@jaegeuk-macbookpro.roam.corp.google.com>
 <20180830040458.GB97850@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830040458.GB97850@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/8/30 12:04, Jaegeuk Kim wrote:
> 1. Create a file in an encrypted directory
> 2. Do GC & drop caches
> 3. Read stale data before its bio for metapage was not issued yet
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
