From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: add remount_fs callback support
Date: Thu, 6 Jun 2013 22:05:00 +0900
Message-ID: <CAKYAXd9_jPS4vBMb+jdQBxQ76Q875zio+uMb7uGTgz4N=jxQzw@mail.gmail.com>
References: <1370071212-7715-1-git-send-email-linkinjeon@gmail.com>
	<51AD698F.3020305@cn.fujitsu.com>
	<CAKYAXd_jFuG00-HWQREKieXdqBGEAs+W0imvYZjCpGAH5S4H9A@mail.gmail.com>
	<51B03FB0.80306@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linkinjeon@gmail.com>) id 1UkZsJ-0003po-1u
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 06 Jun 2013 13:05:07 +0000
Received: from mail-pd0-f181.google.com ([209.85.192.181])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UkZsI-0006Rf-CR
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 06 Jun 2013 13:05:07 +0000
Received: by mail-pd0-f181.google.com with SMTP id 14so686261pdj.26
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 06 Jun 2013 06:05:00 -0700 (PDT)
In-Reply-To: <51B03FB0.80306@cn.fujitsu.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: Namjae Jeon <namjae.jeon@samsung.com>, Pankaj Kumar <pankaj.km@samsung.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

[snip]
>>
>>>
>>>> +
>>>> +     /**
>>>> +      * We stop the GC thread if FS is mounted as RO
>>>> +      * or if background_gc = 0 is passed in mount
>>>> +      * option. Also sync the filesystem.
>>>> +      */
>>>> +     if ((*flags & MS_RDONLY) || !test_opt(sbi, BG_GC)) {
>>>
>>>
>>> Another condition: The old mount is not RO.
>> I don't think that it is needed. I think current condition check can
>> be covered about all cases.
>> Am I missing something ?
>
Hi Gu.
> Maybe. If the old mount is RO, so does the remount. It still can pass the judgement here, right?
> Though the following stop_gc_thread() and f2fs_sync_fs() can handle this case well, but this
> is unnecessary and needless. If we add additional judgement of whether old mount is not RO can avoid this.
>
Okay, I understand.
I will update it on v2 patch.

Thanks~.
> Thanks,
> Gu
>
>>
>>>

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
