Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD6E606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 05:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fAThAQjF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=karhOJA+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=j27JhIPN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=3y1k6BDOZMU/s+nViOQIxAhrZktRqPiLEexj+rRuPpk=; b=fAThAQjFeHP6LgsNUx2q244fGK
	sHQDN0JEv+ZRVqjY6Gx4FyCGCtwoHzN5nNdJcjjh5YIwpEJKkDmHDWuvx8BmpMSAiPKp5+45RAQ5U
	Hc4RNeyE3Qr6kv3uAhij1hdK7tHqmdy4sodUWdZ1JLBn01l3KJxiXlwbEcZyj0EIF5j8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSoty-000000006Sf-2OqZ;
	Mon, 16 Nov 2026 05:05:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3n4f6agkbAPYqwxiYjjcpYnngb.emmejcsqcpamlrclr.amk@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1xSotx-000000006SZ-2tMb
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 05:05:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2SWkMY6Morz5zWTeFku6KKcVFQ9yVAcTTQCwIrhHE9s=; b=karhOJA+IUUpmpipoqgoLa6CMA
 0pO/7E5PtG/nWV3qcFH21rer8lrsyPuqmgS8BqncOSKzUBibBtqY6k0w4jSMpZbM14PJQJJC6DMWl
 FzUqyYBCHHZAJeMC5TNsBZbvRSg4ZtuhhF2UXGqdyiGMFawtvls9qua0t7kqhKi3tYp8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2SWkMY6Morz5zWTeFku6KKcVFQ9yVAcTTQCwIrhHE9s=; b=j27JhIPN/ZCbxM/u/ufrfLdG25
 GhwGgigr7+zxIYUH9AedM4jGbRXo/Z4PnriKHusnSZucQYq52BMc0P/vb1/5yHOz1zVfRpV1WdFK/
 08zcTdtzUF+n/reeUA4jQsekZ/zvaXUAD53ibYn+9RokzGBsBbRh27UklkTzoKUnzn9w=;
Received: from mail-dy1-f197.google.com ([74.125.82.197])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSotw-000000006xR-1Lwc
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 05:05:09 +0000
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36efb506f29so2083318eec.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 21:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794805503; x=1795410303;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2SWkMY6Morz5zWTeFku6KKcVFQ9yVAcTTQCwIrhHE9s=;
 b=R3NvQXwU1NI1fZ9460HeCvj7siFwiIj39lgbFqixIMk2x+EDFtFU6USdv4Qm7Qk3m4
 DNeXnEdx/7vuNocCk4F7LxhaeboLAFsRF9WoWqk6INMbrIlvJQKpu+UTOoY2ZfrGevlY
 2A5Yr4wf0P72H6NYvDI50qAbPDKfFkUf+7ujavJSQ82EAy5OBgu4572BLfqTUoMVBH6w
 E3XByA54g8Go8Sj4huZsBD40zyiRoIW6ux6H+9wTsgTy625/QMjr0NnoAB5mb2Tn1Kuz
 fsRUFGhniZa+uAn2DHstVAIiQ+dStCt7Y+rRLCmjepH2fGtRpC81VfBeEciiGIhrYjoA
 X6Lg==
X-Forwarded-Encrypted: i=1;
 AL+hErEYY8Pdb5mqxh7PpDQKoPNM2oDsCleHV03j3gVI29zeKr1G1SKCI2SWLX6AcvBKu2Nz7cAkQpY3MRxFnM1YxVga@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9vY44f0nTPrncmnoQhBdMXmrZBwHWh/6rp5qWZe6Be0dQOaa1Q
 adrWv7CgU5Vh1J6rJ+1W2fmmeYYwiF0yL58F2tEUbMkAmuK/Y7H6TIbCkVNwIZwyZxf+EeGIxkW
 lCP753xBOK5c8Ts0lMLpHHOg5zoPg3gMknMd0Gtw9DvZCn+TnSPOxQVIxhg0=
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6b8e:b0:574:6f37:6721 with SMTP id
 5614622812f47-5746f382304mr1095716b6e.11.1794803615269; Sun, 15 Nov 2026
 20:33:35 -0800 (PST)
Date: Sun, 15 Nov 2026 20:33:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6afa879f.920b2b3a.148c65.0062.GAE@google.com>
From: syzbot <syzbot+list6ddd297964bb51e043dd@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Spam-Score: 0.6 (/)
X-Headers-End: 1xSotw-000000006xR-1Lwc
Subject: [f2fs-dev] [syzbot] Monthly f2fs report (Nov 2026)
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello f2fs maintainers/developers,

This is a 31-day syzbot report for the f2fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/f2fs

During the period, 0 new issues were detected and 0 were fixed.
In total, 10 issues are still open and 84 have already been fixed.
There is also 1 low-priority issue.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2628    Yes   kernel BUG in f2fs_evict_inode (4)
                  https://syzkaller.appspot.com/bug?extid=5c81eb8c0a380fa578b5
<2> 1368    Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<3> 305     Yes   INFO: task hung in f2fs_issue_checkpoint (2)
                  https://syzkaller.appspot.com/bug?extid=8a7eea50810efde15b0a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
