From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: sepearte hot/cold in free nid
Date: Fri, 20 Apr 2018 11:14:52 +0800
Message-ID: <d0712a2c-393f-a11e-f1de-bab9ce148bab@huawei.com>
References: <20180420015231.90679-1-yuchao0@huawei.com>
 <42B685BFA705F94C860C6DD0752F056548377C3C@DGGEMA503-MBS.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <42B685BFA705F94C860C6DD0752F056548377C3C@DGGEMA503-MBS.china.huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: heyunlei <heyunlei@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/4/20 10:30, heyunlei wrote:
> 
> 
>> -----Original Message-----
>> From: Chao Yu [mailto:yuchao0@huawei.com]
>> Sent: Friday, April 20, 2018 9:53 AM
>> To: jaegeuk@kernel.org
>> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
>> Subject: [f2fs-dev] [PATCH] f2fs: sepearte hot/cold in free nid
>>
>> As most indirect node, dindirect node, and xattr node won't be updated
>> after they are created, but inode node and other direct node will change
>> more frequently, so store their nat entries mixedly in whole nat table
>> will suffer:
>> - fragment nat table soon due to different update rate
>> - more nat block update due to fragmented nat table
>>
> 
> BTW, should we enable this patch:  f2fs: reuse nids more aggressively?
> 
> I think it will decrease nat area fragment and will decrease io of nat?

For a fragmented nat table, there will be no different in between reusing
obsolete nid or allocating nid from next nat block.

IMO, in order to decrease nat block write, it needs to add more allocation
algorithm like a filesystem does, but firstly, I'd like to separate hot entry
from cold one.

Thanks,
