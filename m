From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] f2fs: fix to add refcount once page is tagged
 PG_private
Date: Wed, 13 Mar 2019 09:24:29 +0800
Message-ID: <ea97b878-bbbc-8eb0-540f-ce8c67db9dd8@huawei.com>
References: <20190306093059.80014-1-yuchao0@huawei.com>
 <20190312190446.GC45421@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312190446.GC45421@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/3/13 3:04, Jaegeuk Kim wrote:
>> +static inline void f2fs_set_page_private(struct page *page,
>> +						unsigned long date)
> 
> I fixed to use "data".

Thank you. :)

Thanks,
