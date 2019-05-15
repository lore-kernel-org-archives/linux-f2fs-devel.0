From: Chao Yu <yuchao0@huawei.com>
Subject: Re: BUG: kernel stack overflow when mounting with
 data_flush
Date: Wed, 15 May 2019 10:25:25 +0800
Message-ID: <f657d41f-84d6-8cfa-5532-689a03ab2d2e@huawei.com>
References: <CADoWrG_NTz29eyaa3fUti2sNBP4xp7-zfhDVkix=Kty4rD=Otw@mail.gmail.com>
 <35b643e5-562c-942d-67ce-4a9dbef66d16@huawei.com>
 <5725124a-95c8-cedb-d3a8-d8be86d260dd@huawei.com>
 <CADoWrG9_5izaUMvB0mNLC7yp_Mnnm7yPrqcOvDL2ERR2YrkF2A@mail.gmail.com>
 <452dad75-a4aa-2366-b704-ee5448a3bd71@huawei.com>
 <CADoWrG9V7nD4wzj0DFDAKcjcZHhjC0yPetX_Ce6jj2_YNpU9YA@mail.gmail.com>
 <274e1288-a2ac-4be8-708e-80e75d30813d@kernel.org>
 <CADoWrG88d5XH5tf9iEz7+Agz553S_DBbvisffzv0d8PuU9Cv7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hQjbt-0005hT-Kx
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 May 2019 02:25:37 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hQjbr-004AIj-TQ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 May 2019 02:25:37 +0000
In-Reply-To: <CADoWrG88d5XH5tf9iEz7+Agz553S_DBbvisffzv0d8PuU9Cv7Q@mail.gmail.com>
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
To: Hagbard Celine <hagbardcelin@gmail.com>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>

On 2019/5/15 2:13, Hagbard Celine wrote:
> 2019-04-02 15:31 GMT+02:00, Chao Yu <chao@kernel.org>:
>> On 2019-4-2 20:41, Hagbard Celine wrote:
>>> That seems to have fixed it. No more errors in syslog after extracting
>>> my stage3 tarball. Also ran a couple of kernel compiles on a partition
>>> mounted with data_flush and system seems stable.
>>
>> Thanks a lot for your quick test. :)
> 
> My test might have been a little too quick, or I found another
> data_flush bug that behaves similar.

oops...

>>>>
>>>> -		if (is_dir)
>>>> -			F2FS_I(inode)->cp_task = current;
>>>> +		F2FS_I(inode)->cp_task = current;

If you're sure that this patch was applying before you test, I guess we need an
extra barrier here to avoid out-of-order execution.

smp_mb()

>>>>
>>>>  		filemap_fdatawrite(inode->i_mapping);
>>>>
>>>> -		if (is_dir)
>>>> -			F2FS_I(inode)->cp_task = NULL;
>>>> +		F2FS_I(inode)->cp_task = NULL;

Thanks,
