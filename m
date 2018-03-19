From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/2] tools: sg_write_buffer: add
 sg_write_buffer for FFU
Date: Mon, 19 Mar 2018 10:40:11 +0800
Message-ID: <4d49ef62-6c86-774f-ac9c-709c61d9c1d3@huawei.com>
References: <20180314000839.33075-1-jaegeuk@kernel.org>
 <20180314000839.33075-2-jaegeuk@kernel.org>
 <3e63efd4-99bd-4352-b3fd-a24658beccb7@huawei.com>
 <20180317045957.GA52997@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1exkj1-0007D9-C2
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Mar 2018 02:40:39 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1exkiz-001qQE-FW
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Mar 2018 02:40:39 +0000
In-Reply-To: <20180317045957.GA52997@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Hyojun Kim <hyojun@google.com>, Jaegeuk Kim <jaegeuk@google.com>, linux-f2fs-devel@lists.sourceforge.net

On 2018/3/17 12:59, Jaegeuk Kim wrote:
> On 03/16, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2018/3/14 8:08, Jaegeuk Kim wrote:
>>> From: Hyojun Kim <hyojun@google.com>
>>>
>>> sg_write_buffer sources are added for FFU.
>>
>> Could you please explain more details about why we need to add those source
>> codes? ;)
> 
> We need this for FFU. What else do we need?

You mean Field Firmware Update?

Oh, I don't know, just be curious to know how f2fs using these drive to do FFU.

Thanks,

> 
>>
>> Thanks,
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
