From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't clear CP_QUOTA_NEED_FSCK_FLAG
Date: Thu, 28 Feb 2019 09:08:27 +0800
Message-ID: <f5b5832f-293c-a794-f55f-0a5e46031d07@huawei.com>
References: <20190212023343.52215-1-jaegeuk@kernel.org>
 <df77f830-e5dd-5943-d5b0-e21ced3a7df2@huawei.com>
 <20190216045530.GA57019@jaegeuk-macbookpro.roam.corp.google.com>
 <29a4fd24-6340-41df-7199-6e89b70c6341@huawei.com>
 <20190220070855.GA91331@jaegeuk-macbookpro.roam.corp.google.com>
 <c39a995f-9bfd-e68a-7d04-11bd8c0f8e64@huawei.com>
 <7580aa2e-b2eb-a686-a19d-4e82a713944a@huawei.com>
 <20190222024058.GA6093@jaegeuk-macbookpro.roam.corp.google.com>
 <0e00fefb-d0af-6143-afcd-6d8c8fa34743@huawei.com>
 <20190226175725.GB59048@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226175725.GB59048@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/2/27 1:57, Jaegeuk Kim wrote:
>        /*
>         * TODO: we count on fsck.f2fs to clear this flag until we figure out
>         * missing cases which clear it incorrectly.
>         */
> 
> I added like this.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks,
