From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200465] null ptr dereference in
 fscrypt_do_page_crypto() when operating a file on a corrupted f2fs image
Date: Thu, 20 Sep 2018 21:11:13 +0000
Message-ID: <bug-200465-202145-sXAhavRYeQ@https.bugzilla.kernel.org/>
References: <bug-200465-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1g36EO-0002DG-2y
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Sep 2018 21:11:24 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g36EL-00H9wU-Oq
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Sep 2018 21:11:23 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id A94DA2E266
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 20 Sep 2018 21:11:13 +0000 (UTC)
In-Reply-To: <bug-200465-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=200465

--- Comment #4 from Wen Xu (wen.xu@gatech.edu) ---
(In reply to Chao Yu from comment #3)
> Steve,
> 
> I figure out that patch to solve issue which I encounter with image attached
> by Wen Xu, the bug can be triggered with below scripts:
> - mount image /mnt/f2fs/
> - cd /mnt/f2fs/foo/bar/
> - ls -l
> 
> After applying that patch, the problem was gone.
> 
> But when the bug triggeres, related call stack is not the same as reported
> one, also I can't reproduce reported call stack with the method provided
> from Wen Xu.
> 
> I guess the right producing way is adding master key for encrypted file, I'd
> like to confirm with Wen Xu.

Hi Chao,

Sorry for a late reply! Eh the first thing is that I never did anything like
adding master key for encrypted file. Second, I feel I pasted wrong
(mismatched) kernel message/PoC...but unfortunately I do not have a local copy
on my laptop now.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
