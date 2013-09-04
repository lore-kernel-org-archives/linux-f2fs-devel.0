From: Jin Xu <jinuxstyle@gmail.com>
Subject: Re: [PATCH] f2fs: optimize gc for better performance
Date: Thu, 05 Sep 2013 07:58:37 +0800
Message-ID: <5227C92D.4040109@gmail.com>
References: <1377737323-11803-1-git-send-email-jinuxstyle@gmail.com> <1377777368.2354.46.camel@kjgkr> <52201A4F.9020808@gmail.com> <1378169118.2354.56.camel@kjgkr> <522677ED.8090203@gmail.com> <1378287635.2354.84.camel@kjgkr> <522732EB.4020103@gmail.com> <1378338609.2354.86.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1378338609.2354.86.camel@kjgkr>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Yes, I will submit the patch later.

On 05/09/2013 07:50, Jaegeuk Kim wrote:
> Hi Jin,
>
> 2013-09-04 (=EC=88=98), 21:17 +0800, Jin Xu:
>> Hi Jaegeuk,
>>
>> On 04/09/2013 17:40, Jaegeuk Kim wrote:
>>> Hi Jin,
>>>
>>> 2013-09-04 (=EC=88=98), 07:59 +0800, Jin Xu:
>>>> Hi Jaegeuk,
>>>>
>>>> On 03/09/2013 08:45, Jaegeuk Kim wrote:
>>>>> Hi Jin,
>>>>>
>>>>>> [...]
>>>>>>>
>>>>>>> It seems that we can obtain the performance gain just by settin=
g the
>>>>>>> MAX_VICTIM_SEARCH to 4096, for example.
>>>>>>> So, how about just adding an ending criteria like below?
>>>>>>>
>>>>>>
>>>>>> I agree that we could get the performance improvement by simply
>>>>>> enlarging the MAX_VICTIM_SEARCH to 4096, but I am concerning the
>>>>>> scalability a little bit. Because it might always searching the =
whole
>>>>>> bitmap in some cases, for example, when dirty segments is 4000 a=
nd
>>>>>> total segments is 409600.
>>>>>>> [snip]
>>>>>> [...]
>>>>>>>
>>>>>>> 	if (p->max_search > MAX_VICTIM_SEARCH)
>>>>>>> 		p->max_search =3D MAX_VICTIM_SEARCH;
>>>>>>>
>>>>>>
>>>>>> The optimization does not apply to SSR mode. There has a reason.
>>>>>> As noticed in the test, when SSR selected the segments that have=
 most
>>>>>> garbage blocks, then when gc is needed, all the dirty segments m=
ight
>>>>>> have very less garbage blocks, thus the gc overhead is high. Thi=
s might
>>>>>> lead to performance degradation. So the patch does not change th=
e
>>>>>> victim selection policy for SSR.
>>>>>
>>>>> I think it doesn't care.
>>>>> GC is only triggered during the direct node block allocation.
>>>>> What it means that we need to consider the number of GC triggers =
where
>>>>> the GC triggers more frequently during the normal data allocation=
 than
>>>>> the node block allocation.
>>>>> So, I think it would not degrade performance significatly.
>>>>>
>>>>> BTW, could you show some numbers for this?
>>>>> Or could you test what I suggested?
>>>>>
>>>>> Thanks,
>>>>>
>>>>
>>>> I re-ran the test and got the following result:
>>>>
>>>> ---------------------------------------
>>>> 2GB SDHC
>>>> create 52023 files of size 32768 bytes
>>>> random re-write 100000 records of 4KB
>>>> ---------------------------------------
>>>>
>>>> | file creation (s) | rewrite time (s) | gc count | gc garbage blo=
cks |
>>>>
>>>> no patch       341         4227             1174          174840
>>>> patched        296         2995             634           109314
>>>> patched (KIM)  324         2958             645           106682
>>>>
>>>> In this test, it does not show the minor performance degradation c=
aused
>>>> by applying the patch to SSR mode. Instead, the performance is a l=
ittle
>>>> better with what you suggested.
>>>>
>>>> I agree that the performance degradation would not be significant =
even
>>>> it does degrade. I ever saw the minor degradation in some workload=
s, but
>>>> I didn't save the data.
>>>>
>>>> So, I agree that we can apply the patch to SSR mode as well.
>>>>
>>>> And do you still have concerns about the formula for calculating t=
he #
>>>> of search?
>>>
>>> Thank you for the test. :)
>>> What I've concerned is that, if it is really important to get a vic=
tim
>>> more accurately for the performance as you described, it doesn't ne=
ed to
>>> calculate the number of searches IMO. Just let's select nr_dirty. W=
hy
>>> not?
>>> Only the thing that we should consider is to handle the case where =
the
>>> nr_dirty is too large.
>>> For this, we can just limit the # of searches to avoid performance
>>> degradation.
>>>
>>> Still actually, I'm not convincing the effectiveness of your formul=
a.
>>> If possible, could you show it with numbers?
>>
>> It's not easy to prove the effectiveness of the formula. It's just f=
or
>> eliminating my concern on the scalability of searching. Since it doe=
s
>> not matter much for the performance improvement, we can put it aside
>> and choose the simpler method as you suggested.
>>
>> So, should I revise the patch based on what you suggested or will
>> you take care of it?
>
> Could you make a patch with your performance description and sumbit i=
t
> again?
> Thanks a lot,
>

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
