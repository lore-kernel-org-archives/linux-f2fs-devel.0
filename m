From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202989] [MSM-4.14] kernel panic during F2FS GC
Date: Mon, 25 Mar 2019 04:02:16 +0000
Message-ID: <bug-202989-202145-BbDfZmBBq1@https.bugzilla.kernel.org/>
References: <bug-202989-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1h8Gob-0008Cc-Cb
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Mar 2019 04:02:25 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h8GoZ-005s8Y-Pe
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Mar 2019 04:02:25 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 5717629073
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 25 Mar 2019 04:02:17 +0000 (UTC)
In-Reply-To: <bug-202989-202145@https.bugzilla.kernel.org/>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

https://bugzilla.kernel.org/show_bug.cgi?id=202989

--- Comment #9 from yuchao0@huawei.com ---
On 2019/3/25 11:38, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=202989
> 
> --- Comment #8 from Lianjun Huang (hlianjun@gmail.com) ---
> (In reply to Chao Yu from comment #7)
>> I've changed this issue's title to indicate it is from private code repo.
> It is OK.
> 
>>
>> Could you add to Cc below email address of qualcomm's guys, since maybe they
>> can provide some help.
>>
>> stummala@codeaurora.org
>> riteshh@codeaurora.org
> 
> I failed to CC the email addresses above, they seem not to register kernel
> Bugzilla.

Let me Cc them directly. :)

To Sahitya, Ritesh

Do you have time to take a look at this issue?

Thanks,

>

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
