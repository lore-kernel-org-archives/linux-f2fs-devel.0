From: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] f2fs: Reduce zoned block device memory usage
Date: Tue, 5 Mar 2019 23:53:23 +0000
Message-ID: <BYAPR04MB5816384EDAD93573F4467159E7720@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190304070416.13429-1-damien.lemoal@wdc.com>
 <bae73801-92f5-f7a0-c6a0-941c90219866@suse.de>
 <BYAPR04MB58167832101386B8EA03E037E7720@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190305165534.GA78380@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=9610ee5ea=Damien.LeMoal@wdc.com>)
 id 1h1K7Z-0003jU-Nc
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Mar 2019 00:09:17 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h1K7L-00CXSr-K4
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Mar 2019 00:09:17 +0000
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
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, Matias Bjorling <Matias.Bjorling@wdc.com>, Johannes Thumshirn <jthumshirn@suse.de>

On 2019/03/06 1:55, Jaegeuk Kim wrote:
> On 03/05, Damien Le Moal wrote:
>> Johannes,
>>
>> On 2019/03/04 18:46, Johannes Thumshirn wrote:
>>> Hi Damien,
>>>
>>> On 04/03/2019 08:04, Damien Le Moal wrote:
>>>> @@ -2765,9 +2765,11 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
>>>>  	if (nr_sectors & (bdev_zone_sectors(bdev) - 1))
>>>>  		FDEV(devi).nr_blkz++;
>>>>  
>>>> -	FDEV(devi).blkz_type = f2fs_kmalloc(sbi, FDEV(devi).nr_blkz,
>>>> -								GFP_KERNEL);
>>>> -	if (!FDEV(devi).blkz_type)
>>>> +	FDEV(devi).blkz_seq = f2fs_kzalloc(sbi,
>>>> +					BITS_TO_LONGS(FDEV(devi).nr_blkz)
>>>> +					* sizeof(unsigned long),
>>>> +					GFP_KERNEL);
>>>> +	if (!FDEV(devi).blkz_seq)
>>>>  		return -ENOMEM;
>>>
>>> Not so sure about F2FS internals, but there is a bitmap_zalloc() in the
>>> normal kernel library.
>>
>> Yes indeed... f2fs_kzalloc uses f2fs_kmalloc(__GFP_ZERO) and f2fs_kmalloc is
>> basically kmalloc() or kvmalloc() but with error injection for tests. So I used
>> that instead of bitmap_zalloc() to preserve the error injection test.
>>
>> Jaegeuk,
>>
>> Which do you prefer ? The patch as it is or switching to bitmap_zalloc() ?
>> Whichever is fine with me so I can send a v2 if you prefer bitmap_zalloc().
> 
> Hi Damien,
> 
> I think f2fs_kmalloc would be fine for fault injection tests. It seems it'd
> better to write a clean-up patch which replaces all the bitmap allocations
> in f2fs with single f2fs_bitmap_zalloc() at once.

Sounds good to me. So will you take the patch as is ? Any comment on it ?
This change was tested on a 15TB SMR disks.

> 
> I'll take a look at this.
> Thanks,
> 
>>
>> Best regards.
>>
>> -- 
>> Damien Le Moal
>> Western Digital Research
> 


-- 
Damien Le Moal
Western Digital Research
