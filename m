From: Sotirios-Efstathios Maneas <smaneas@cs.toronto.edu>
Subject: Re: [Bug 200871] F2FS experiences data loss (entry is
 completely lost) when an I/O failure occurs.
Date: Thu, 20 Sep 2018 21:50:23 -0400
Message-ID: <D791877F-61CA-4C52-924F-F99D2811666F@cs.toronto.edu>
References: <bug-200871-202145@https.bugzilla.kernel.org/>
 <bug-200871-202145-qvfYvG2xuV@https.bugzilla.kernel.org/>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <smaneas@cs.toronto.edu>) id 1g3Aaa-0007Tf-Un
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Sep 2018 01:50:36 +0000
Received: from aviary.cs.toronto.edu ([128.100.3.90])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:DHE-RSA-AES128-SHA:128) (Exim 4.90_1) id 1g3AaX-003Vxh-8P
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Sep 2018 01:50:36 +0000
Received: from cpe9050cac54833-cm9050cac54830.cpe.net.cable.rogers.com
 ([99.246.204.57] helo=[192.168.0.11])
 by aviary.cs.toronto.edu (as smtp.cs.toronto.edu) with esmtpsa
 (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.82)
 (envelope-from <smaneas@cs.toronto.edu>) id 1g3AaO-0006xI-Jm
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Sep 2018 21:50:24 -0400
In-Reply-To: <bug-200871-202145-qvfYvG2xuV@https.bugzilla.kernel.org/>
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

Dear all,

I was kindly wondering if there are updates on this issue.

Thanks a lot in advance.

Kind regards,
Stathis Maneas

> On Sep 5, 2018, at 5:42 PM, bugzilla-daemon@bugzilla.kernel.org wrote:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=200871
> 
> --- Comment #8 from Stathis Maneas (smaneas@cs.toronto.edu) ---
> Created attachment 278337
>  --> https://bugzilla.kernel.org/attachment.cgi?id=278337&action=edit
> Simple C file that updates the permissions of a file.
> 
> -- 
> You are receiving this mail because:
> You are watching the assignee of the bug.
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
