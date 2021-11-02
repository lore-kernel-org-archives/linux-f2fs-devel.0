Return-Path: <SRS0=51XN=PV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C023C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  2 Nov 2021 06:51:14 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E7660F02;
	Tue,  2 Nov 2021 06:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D7E7660F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mhndY-00025e-Kw; Tue, 02 Nov 2021 06:51:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1mhndX-00025Q-HI
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Nov 2021 06:51:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SFlcVyva7g4hYN2JXM+EzozPzbqtYkd4A0qMjC4U/vI=; b=YDZ3CeU98ml76MOEu6G0+w4gMg
 FGrXOfVqu2zg4MErpyeYsyKKK13qSo3ohBCsgK1+E8lTBfgZVTBmxAKp/XUX4G88Rn9JprExw20XW
 koRo7ecqd/Pli6oCWYeCdb1dgBMIa4CFep3o+jQKV442XxKwNXMXMVtSQ1el0L0j4ayA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SFlcVyva7g4hYN2JXM+EzozPzbqtYkd4A0qMjC4U/vI=; b=F0ofKOE0F5T4EBEE6jrVwh6t47
 TlyJ2d2uEDZYuDrRxKkvIwCzm6SGJoufoBl2HY4v3e9tMfL4/QswZX7QPBoEsjjzaSG/XiMYrXmTR
 CjchjSnID7liy7O8KMoF3T1ULyr8LD/H1Tv46woEUs7L/vqMwFgQckMuWftwBLjE9oNo=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mhndU-00EAUj-70
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Nov 2021 06:51:11 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF20860E8C;
 Tue,  2 Nov 2021 06:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635835858;
 bh=0m2h0gxAR4wB7PVa2oQ4sTYz0e/lrZ3V9+uXt+Kp2iQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=V4RIxDv66FDQB9Lz6AzG2yzCDhVK0M+pR1pxC7lLvjwypxqOxy+C1oK1o0OShzvPR
 6Bm3jftA0uM9QniEDtQ7pKfQTeJlmSER5ZtsEqUczSS+Fuw96r7wKE+erQ2JnvBG4j
 Gzjo3b5Nq6ziIE9T3vDa8ZlhKbl6tpRKrYq0SgOTeNsrIeHRi3iwSP4by6mcgWK6eu
 OT4L8hNtKYxup4GYO8LBKOvMeLbZH8Kzc22S/goWprl/zuojCTiDZk4Uk7CpW73Q7Z
 WB7QOfqoRqu1gk5rfA0gQFYYLQ+agPc9IEth3E0GW66X1AVIJDaNSHTPdW/NhwawVf
 G+5kjhYCobM/w==
Message-ID: <1f724fcc-6a32-6483-444c-53c78376201d@kernel.org>
Date: Tue, 2 Nov 2021 14:50:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To: Hyeong-Jun Kim <hj514.kim@samsung.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <CGME20211102045952epcas1p44cb6fd41baa76a19e0924c4b6b3cf1e6@epcas1p4.samsung.com>
 <20211102045949.63530-1-hj514.kim@samsung.com>
 <9ee5741f-35f8-c0b9-f045-fb70aa49f6de@kernel.org>
 <cc63ca8752da7932b57769d58fce68dea5d9a8bc.camel@samsung.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <cc63ca8752da7932b57769d58fce68dea5d9a8bc.camel@samsung.com>
X-Headers-End: 1mhndU-00EAUj-70
Subject: Re: [f2fs-dev] [PATCH v3] F2FS: invalidate META_MAPPING before
 IPU/DIO write
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: sj1557.seo@samsung.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/11/2 14:49, Hyeong-Jun Kim wrote:
> On Tue, 2021-11-02 at 14:47 +0800, Chao Yu wrote:
>> On 2021/11/2 12:59, Hyeong-Jun Kim wrote:
>>> Encrypted pages during GC are read and cached in META_MAPPING.
>>> However, due to cached pages in META_MAPPING, there is an issue
>>> where
>>> newly written pages are lost by IPU or DIO writes.
>>>
>>> Thread A - f2fs_gc()            Thread B
>>> /* phase 3 */
>>> down_write(i_gc_rwsem)
>>> ra_data_block()       ---- (a)
>>> up_write(i_gc_rwsem)
>>>                                   f2fs_direct_IO() :
>>>                                    - down_read(i_gc_rwsem)
>>>                                    - __blockdev_direct_io()
>>>                                    - get_data_block_dio_write()
>>>                                    - f2fs_dio_submit_bio()  ---- (b)
>>>                                    - up_read(i_gc_rwsem)
>>> /* phase 4 */
>>> down_write(i_gc_rwsem)
>>> move_data_block()     ---- (c)
>>> up_write(i_gc_rwsem)
>>>
>>> (a) In phase 3 of f2fs_gc(), up-to-date page is read from storage
>>> and
>>>       cached in META_MAPPING.
>>> (b) In thread B, writing new data by IPU or DIO write on same
>>> blkaddr as
>>>       read in (a). cached page in META_MAPPING become out-dated.
>>> (c) In phase 4 of f2fs_gc(), out-dated page in META_MAPPING is
>>> copied to
>>>       new blkaddr. In conclusion, the newly written data in (b) is
>>> lost.
>>>
>>> To address this issue, invalidating pages in META_MAPPING before
>>> IPU or
>>> DIO write.
>>>
>>> ---
>>> v3:
>>>    - Use sbi instead of fio->sbi in f2fs_inplace_write_data()
>>> v2:
>>>    - Update patch description with race condition
>>
>>
>>
>>> Fixes: 6aa58d8ad20a ("f2fs: readahead encrypted block during GC")
>>> Signed-off-by: Hyeong-Jun Kim <
>>> hj514.kim@samsung.com
>>>>
>>> ---
>>
>> Change log should be attached here, otherwise Fixes & Signed-off-by
>> tag will be lost
>> after applying this patch.
>>
>> Thanks,
>>
> Thanks for your comment.
> Should I re-send this patch?

Yes, please. :)

Thanks,

> 
> Thanks,
>>>    fs/f2fs/data.c    | 2 ++
>>>    fs/f2fs/segment.c | 3 +++
>>>    2 files changed, 5 insertions(+)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 74e1a350c1d8..9f754aaef558 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -1708,6 +1708,8 @@ int f2fs_map_blocks(struct inode *inode,
>>> struct f2fs_map_blocks *map,
>>>    		 */
>>>    		f2fs_wait_on_block_writeback_range(inode,
>>>    						map->m_pblk, map-
>>>> m_len);
>>> +		invalidate_mapping_pages(META_MAPPING(sbi),
>>> +						map->m_pblk, map-
>>>> m_pblk);
>>>    
>>>    		if (map->m_multidev_dio) {
>>>    			block_t blk_addr = map->m_pblk;
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 526423fe84ce..df9ed75f0b7a 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -3652,6 +3652,9 @@ int f2fs_inplace_write_data(struct
>>> f2fs_io_info *fio)
>>>    		goto drop_bio;
>>>    	}
>>>    
>>> +	invalidate_mapping_pages(META_MAPPING(sbi),
>>> +				fio->new_blkaddr, fio->new_blkaddr);
>>> +
>>>    	stat_inc_inplace_blocks(fio->sbi);
>>>    
>>>    	if (fio->bio && !(SM_I(sbi)->ipu_policy & (1 <<
>>> F2FS_IPU_NOCACHE)))
>>>
>>
>>
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
