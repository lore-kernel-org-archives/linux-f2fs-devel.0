Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3CFC88E50
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Mn2qzU7B2cpEBfeioW/zKDjJ4TGSkJPtxMzK+Febi8E=; b=ex70NggY70B9VLsSB79U8/YiQv
	pAoZ9gnllCmr3k1DhBoEJpB3bWYzfzTGl/Ix0VUE82HkCPK8jI4eJivYUZe2fHGCGp2W8J4ZrtVTU
	Lllpr/91C40HdDZ+EA/6XL+pgDoY8rfDs386Uvv+I2n/nf030fmXEBZUIboMhFU2Vh5Y=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x50Rk-0004Vq-Fo;
	Fri, 11 Sep 2026 12:33:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3GPWjagkbAO0hnoZPaaTgPeeXS.VddVaTjhTgRdciTci.Rdb@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1x50Ri-0004Vi-G3 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 12:33:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DdtJlR6Fec/YoXlyYI0faEBLW4IkQd167d+YUVIlYTY=; b=Dz9sK3ImkEFyiN2KMi3M7Cq0fa
 0u+MyyQgtW2kv+Xm3kAS2rCQ7vEofRPRgQs/rQxvQpVbXDbVBMKUxWKycPac6YKEG+i1vkEsl5A1z
 D4jYOiJnZYyy/0qwkG2R+aPXsSnGLjctGm8Kt9tTOL8PoAk1Yzz4VxCfkp3wPywYuecs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DdtJlR6Fec/YoXlyYI0faEBLW4IkQd167d+YUVIlYTY=; b=H
 WkoZN8oQyzpMwGWDlFU7SmndCE5SS+kq3iTT0YbCoRkdO02IxPINMM3pxKcAnwHDuTRSKB6GeP+Nt
 ockzg/YBSANKZse44SqaA9rw7CZtlsTIie6X3oUFK8ResRNfLBdExuO6gxnEON5Xcj5DXo7qv1Itf
 fFniYLIr65Lemx48=;
Received: from mail-ot1-f70.google.com ([209.85.210.70])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x50Rh-00041R-Pr for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 12:33:35 +0000
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e9dc0f5900so3383794a34.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 05:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789130008; x=1789734808;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DdtJlR6Fec/YoXlyYI0faEBLW4IkQd167d+YUVIlYTY=;
 b=CiLpHXzJybnu0GmcZCS1xp+QbMd6ljAW6wLE+7Tkym8/+Z41oX/GCaVR2JAm6QatMr
 lmmkd/+0KwYwDg/0FzMueBFIgm913aciIT+iF3VKoSn0zJWqkMJnOsjGaxz643HuB+Nw
 jJAT2UPHbExk145hNus5ZYEbQAm/guFzWRf7qsjSwt+OIFDnQK6Ury322W46fSLebj1r
 1C35J5dg6m6IM3FysaOiJXSPuqelhCFknzSgbmhAC4v/008gmkFVaIkgbZfPDQBrE03j
 uiLfm+2dFOxz+3lBl5avorW7tESIhszrYQQXUZoPup4Azqf32pd2LcuWtzKaHxQ3xTOK
 +nsw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzyRn7SDbcu2vgQioURmObNOiuioaA5iDH4p9n0ytYokULk+LMdbm6QRL2btCxg2AYv/viF+XmKx68k1IQTEY44@lists.sourceforge.net
X-Gm-Message-State: AFuF++ktYZmzMBAxOEMukvTcs7XdG05V8U8xziacIFtINb2+jCbseYAW
 hZdjcoL3is4GRL9BfIvskjJ9EZBYx0hMGkfdp27FHBpXL4jbHye3celsyB3/eNt2XAdMXHc36KS
 zcE+p3x7p3mfI3W2OH0/SIZpRymnI//4lF4NpR+pTcvNpct3Sy87Nm+NujoQ=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1889:b0:6b5:ec2f:356f with SMTP id
 006d021491bc7-6bf46bb2c16mr4771584eaf.32.1789130008248; Fri, 11 Sep 2026
 05:33:28 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:33:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa3f518.f2639fcc.29487d.002a.GAE@google.com>
From: syzbot <syzbot+list07391065a6a4e29b292d@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1x50Rh-00041R-Pr
Subject: [f2fs-dev] [syzbot] Monthly f2fs report (Sep 2026)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello f2fs maintainers/developers,

This is a 31-day syzbot report for the f2fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/f2fs

During the period, 3 new issues were detected and 0 were fixed.
In total, 12 issues are still open and 82 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2461    Yes   kernel BUG in f2fs_evict_inode (4)
                  https://syzkaller.appspot.com/bug?extid=5c81eb8c0a380fa578b5
<2> 1367    Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<3> 300     Yes   INFO: task hung in f2fs_issue_checkpoint (2)
                  https://syzkaller.appspot.com/bug?extid=8a7eea50810efde15b0a
<4> 186     No    general protection fault in new_curseg
                  https://syzkaller.appspot.com/bug?extid=ae5b8eb92ed40411ce16

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
