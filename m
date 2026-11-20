Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D6606A320
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 21 Nov 2026 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bIArvaHO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FsMdRxq3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Fiul/Yju;
	dkim=neutral header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=pAWWG7IJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:MIME-Version:Date:To:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=62zcvKZk3gnU+DwDWgpOsdaiYxBlw7lt9ScNaDXIrzk=; b=bIArvaHOfCF7sm
	acwwz3ry8KgiGw558bz/OI2gVuutxMsWJ7z+j19aI2sGMFDBmBdQmtrLa3JXrd5aQDzmfdNA+u9f1
	nu1UtUWvudnrDq7VoONa0hetd1rG7MdtZ4/K9jji/p7peK/sZMlDUJCHhUy5gUUWkF+nePzwH/NO5
	cP4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUgNK-000000003rJ-09h4;
	Sat, 21 Nov 2026 08:23:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <yangguikun19@qq.com>) id 1xUgNI-000000003rC-0tzN
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 08:23:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:MIME-Version:Date:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fKGTplSFuZkys6Gs/DIwLD2p5FEp65r/thrub/uWGhA=; b=FsMdRxq3T0RiMKY28+QDF1twVR
 BCJ7y6RV4cOiozWGGLXP8TQYrYIDHn8SziHGYCIwolO8t8ci74PlIqGhlCYG/RT3777gV2UIqf0bP
 mltR/i06sR6U1TL1eHj9DjrLBnkMWwpc+9QZ116wEcBbCYn43HaXcexq4Pez/fJ6MbJQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:References:In-Reply-To:
 MIME-Version:Date:Subject:Cc:To:From:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fKGTplSFuZkys6Gs/DIwLD2p5FEp65r/thrub/uWGhA=; b=Fiul/Yjux0DysiGbil0zqLpGmp
 R/tSlbx0zpHkA+aa/D0cN+NSVPlpTAk16hIe6d9o5owHaU6DPt4FlTR5rvDnK+7lcpld4ctZn6L9k
 VTqqf1dN0CoPFmtkX1a2PKNsVu+gU3dJeO5WkOrASdxMLB+Dgq2g17L41fHpz+FXzZQs=;
Received: from xmbghk7.mail.qq.com ([43.163.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUgND-000000007LG-3wqZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 08:23:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795249375; bh=fKGTplSFuZkys6Gs/DIwLD2p5FEp65r/thrub/uWGhA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=pAWWG7IJw3ooaTTZU9aZvSXfTjvcnsieB3EoQMrcdtRz+WE8DsHXWCY/3vCw1VsQr
 sqZFU4jUXtWEwfSjAsLG/YvH+BbblxrCnp7MOGFZnOLGpJKqOZzmUAExKj80jPxexo
 O7DrSTO+WGKGejvPhcHws76SYX3jhgj7kGEbTy0s=
Received: from [172.18.4.77] ([202.113.185.209])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id 5B5A06F5; Sat, 21 Nov 2026 16:22:53 +0800
X-QQ-mid: xmsmtpt1795249373tkdbr3ijf
Message-ID: <tencent_BB8EEFED1178A776D3B5A8151FED28F55407@qq.com>
X-QQ-XMAILINFO: MNnlw0eqe4ZE/SrzUrZCmkJAqD5g8jDXfNiRiQLEJUxqea48RP1KkA4gbys0kA
 mnOIs2tsxKPsAjr71CaXYGSc8+ghRsynrKbknElAtCXSiO4wwpcdQa52HjFN31K/0SCs3WD8LAtD
 zRz28uQIRJ8jrDT8k9Z6b/f6FLyUZ8wAJGAeEfWJmy3MYoVMGrJ3sWfnaC94hMtUgHhTUpfmBJW6
 jBY48R1aZV2Gu/uCViF6mPqvHZenWhoFNDifqa6yEtGiNG0y6EerrVAXUdaR5Xjrug5kNh83RNsI
 MApBIv8wZyhzyMi6iQK76F+YBDhC0TAp1TwO1wd9AUVj5XKaj8JAdDLFvNLN1e2nQiW76OeqqsuH
 hnueTItdhwkPLxX1zT3AnPfREtU1HIYdWLtvxxSGsOfSJ56seYyzc51sFlH99ZOrD1/kQXFGr4Un
 TuUpEDaHpY8nMA69bpMAKXygzslS0ZdIqR7UeZtDxxlQ6TG/uZ5zlzxUH+EbGYb1cA6BSRmHEIYg
 THTUL2jZhP9PMDit69yY7dElpB1l06R+ui5MUi5qafsHh8ubqtkRuB2Oq2cKTucJkKrXfglVe7gQ
 K4LeSaONMk71CRRwS9TigiN0v957YGEDqCeE+vc+uSnxm1whfLNF+anjRRvB96pGjG+ofAx8JcgY
 fenV3GtVQ767TlXhA8TrS5w6cNmAUnWYIWT9BOvNPedxde72jk/NBgt5CjUQl/Fjz9EpQYlEvEjP
 b8liqqA6MhpNyWGoCuB4Uy446nOoHLw+y73OWRGFZhmpjqNarCsM3uoQkXcKGf7wXMDPWeM1nr7B
 AF2fEhD/wBRyhdszlBkAna1T8heAFjSPQ6jopMcYIoI/Ub3Mh6LmgXLN2N6siawwxfl1XjVMaUnV
 y3XEBl2qtIFJWRymz3ZesrWiKOpbXY0T1cbHbKtwbwSNxdbEvWErx2JQEGdytsTk072b8m61GrwG
 iZbFrZtn5VbFCFlsjmhi9JI0MGRYqddgcjdqcCfQWmu/h86l91L19F3ILlcdN4XFctXRQl7xZfim
 c3yUH0ivCm9HRCxptEZdREFyiH8JPlR3rsdegJo9FB4oxUIUyXkk91seUJUEpKKZyNuwVlJTl+yR
 KnVyHwuOo/Fo0ihfoZ9G8Hdb5bxEso3NGf6ePoGL4YsOM/8rBEEhdCNjZRJPYHzir5Tlp8KyMHXt
 mHhB+s6me1mOasnw==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 20 Nov 2026 22:00:00 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OQ-MSGID: <f2fs-recover-dentry-warn-list-20261121@qq.com>
In-Reply-To: <f2fs-recover-dentry-warn-20261120@qq.com>
References: <f2fs-recover-dentry-warn-20261120@qq.com>
X-Spam-Score: 0.9 (/)
X-Headers-End: 1xUgND-000000007LG-3wqZ
Subject: [f2fs-dev] f2fs: a same-name dirent whose target inode has no NAT
 entry hits WARN_ON(1) in recover_dentry() at mount - kernel panic with
 panic_on_warn
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Guikun Yang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Guikun Yang <yangguikun19@qq.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

(Resending to the list: my previous mail used a nonexistent
list address linux-f2fs-devel@lists.linux.dev and was rejected;
the correct address from MAINTAINERS is lists.sourceforge.net.
The report below is unchanged.)

Hi Jaegeuk, Chao,

Mounting a crafted f2fs image with fsync data to recover ends in a
WARN_ON(1) during mount-time recovery, before any syscall beyond
mount(); with panic_on_warn the box panics at boot.

  F2FS-fs (vda): f2fs_recover_fsync_data: recovery fsync data, check_only: 0
  F2FS-fs (vda): recover_dentry: inode with [ino:xxx] has invalid encrypted name
  ------------[ cut here ]------------
  WARNING: fs/f2fs/recovery.c:223 at f2fs_recover_fsync_data+...
  Kernel panic - not syncing: kernel: panic_on_warn set ...

## The path

fs/f2fs/recovery.c, recover_dentry():

	de = __f2fs_find_entry(dir, &fname, &dentry_blk);
	if (de && inode->i_ino == le32_to_cpu(de->ino))
		goto out_put;

	if (de) {
		einode = f2fs_iget_retry(inode->i_sb, le32_to_cpu(de->ino));
		if (IS_ERR(einode)) {
			WARN_ON(1);                       /* :223 */
			err = PTR_ERR(einode);
			if (err == -ENOENT)
				err = -EEXIST;
			goto out_put;
		}

The recovered inode's filename is looked up in the parent directory.
When a same-name dirent exists but points at a different ino whose NAT
entry is missing (blk_addr == NULL_ADDR), f2fs_iget() returns -ENOENT
and the function hits WARN_ON(1). Nothing on the way to the assertion
checks that the dirent target exists: the name lookup and the inode
lookup read two independent on-disk structures, and a corrupted or
fuzzed image can leave them inconsistent.

The mount is enough: no post-mount syscall is needed, the recovery
walk reaches the entry as soon as the last checkpoint carries fsync
data for the crafted dentry.

## Related but distinct reports

This is a third independent spot in the same recovery walk:

 - recover_orphan_inode() had f2fs_bug_on(PTR_ERR(inode) == -ENOENT)
   for an orphan whose NAT entry is missing; fixed by treating the
   missing inode as fs corruption (downgrade to f2fs_err +
   SBI_NEED_FSCK) - that fix does not touch recover_dentry().
 - do_recover_data() cross-checks ni.ino against the node footer and
   hits f2fs_bug_on at recovery.c:698 - reported separately.

Same family: an ino read from one on-disk structure does not resolve
through the NAT, and the recovery code asserts instead of treating it
as corruption.

## Reproducer

A crafted image where the fsync dentry entry to recover names a file
whose dirent in the parent block points at an ino with no NAT entry;
mounting the image reproduces the WARNING (3/3 runs with
panic_on_warn=0, panic at boot with panic_on_warn=1). A control image
identical except that the dirent points at an existing inode mounts
and recovers normally.

The image builder and the run script are available on request.

## Versions

Reproduced on 7.3.0 (self-built, panic_on_warn=1 for the panic
demonstration). The WARN_ON(1) at recovery.c:223 is unchanged in
current mainline. No report found on the syzbot dashboard for
recover_dentry/f2fs_iget_retry, and no list thread found for this
assertion.

## Possible fix direction

Treat the missing dirent target like the orphan case: log f2fs_err,
set SBI_NEED_FSCK, skip the dentry (the recovered inode keeps its
name from the fsync entry) or fall back to -EEXIST handling, instead
of WARN_ON(1).

Thanks,
Guikun Yang



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
