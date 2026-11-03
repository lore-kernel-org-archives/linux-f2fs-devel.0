Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6966A606A31B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=A9X/WoW4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=baKmqNYe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=chF3ls0G;
	dkim=neutral header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=jb/P+sUB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Date:To:Message-ID:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=4PuU3TYPSpKOVjCGHIrlRe0aXcK6rbLtJWQNRQhLEws=; b=A9X/WoW4XZc/X4aIxBcEv33tkg
	ZjYKDl79+pyJDvg7O/nHN0TD9+DLfrVLdnAqt+87U0dVFCQ6vr5DDSsrssc+pLXyRd2pZUr7eqRqu
	GPoWFF9n1D2ASOaeNI7TQPY80phKUwWyi0se70G2tSi+ve1vdXNpipux/6fZ/uKY9t9U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOIjo-000000007bu-0IGG;
	Tue, 03 Nov 2026 17:56:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <yangguikun19@qq.com>) id 1xOIjm-000000007bf-2Wne
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 17:55:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Subject:MIME-Version:Content-Transfer-Encoding:
 Content-Type:Date:Cc:To:From:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uMAvHJZEF1Q8OY3SKDQ7nLHVkkIo5TZ9PtucqHYyY2Y=; b=baKmqNYevTG0lzC0BS7NTwsL2I
 pKiIvcVhBg9zkmb/3+LZfTkuLgrZEFYMT4JkwGJYD0ZjCSxpR/YO4Nb7nX87MltLBhY+8fQEo+W7x
 +0FriwMLw4eEH6Ng3sSeN1tlRuSrziCb+x8YWKLjtyfzei+rbcHEVd30/hPsnmFiWi38=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Subject:MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
 From:Message-ID:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uMAvHJZEF1Q8OY3SKDQ7nLHVkkIo5TZ9PtucqHYyY2Y=; b=chF3ls0Gaynv3tyny7Q/kkTHrR
 HBh2T31OlMb7D2JcbSnL9nyYOpRfPtil/mN0Ocgj6nmSfSDnZBMk55pXbk8Zdp9/bpx7pLhJ+0FqM
 buWRcwBXlIY2IHGNFvyzzqCV40q27WoZ3oCAWxtwERzV8xZHrlxGP9tQoRSXRDMRwA6k=;
Received: from xmbghk7.mail.qq.com ([43.163.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOIjj-000000003yf-2n0X
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 17:55:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1793728546; bh=uMAvHJZEF1Q8OY3SKDQ7nLHVkkIo5TZ9PtucqHYyY2Y=;
 h=From:To:Cc:Subject:Date;
 b=jb/P+sUBJNv2xNag6joSqA1CuLQ2vACeE8rgfIt4ucbe+c9Gk7PH+Swx5JtH/4Mb8
 xNYScoP2RmRBl6tNmeQsoMiBijJv1ojobFdi3NsEYFn0RvwZkD+K03q6KaGbx1drCr
 Ny2NowYm3rELmHMIRx6Us6w0rQMIjLtbf2sf3Cwg=
Received: from [172.18.4.77] ([61.136.26.103])
 by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
 id DEDA488B; Wed, 04 Nov 2026 01:55:45 +0800
X-QQ-mid: xmsmtpt1793728545tls6kayob
Message-ID: <tencent_5CEF90115E2715D386A8349FCA28D7D4D607@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJj3htFyhsOHP29A4pKXxwYLWOp5dBtJOvJTXLdv5PgUvblCSIYw
 Uvb2MRl/ysIoQkqWe6vLe/hrY4OhW4sEyVodPDGtH6+EyyB5iDitUPabXoRpJp4R42eLViaC6IYz
 Vs1WWTujeaN7EyFiXiR0sORYXzQfmlp9lWDB3Egda41r121+XS5ZLYHVJ0Ps0mEQNeJmKV8RU/0B
 4FUf0I58e7UCbT8vtJsTtg91B2hOBFv9AiKKwH19NzVxflJ4KaUTRRrp2V+v263Kun1i9zZ/1U76
 Cfj3pDjgSndPrNTZWyAXTYj1F5wigzBjvijga2wk9ApzANzkcmjZlK2VcWWk4sRlW7N/ZIs1talX
 rdHRDeuDUtdk6GYOZuguXoQXWmV/aw6DbJJdUKtbSWHcGx4Ggkfvl3otSP6bc1tWRk2YWF1RXUwp
 Mpx/WD6DYOVrJURZ8+wQ9dKOYZ5I1tssLtbpVppsgPDdghIU5X59JO0Dwt27m8kT62mbhguJgtvB
 b54Hxgba1LwgoIgjLjy2mKS8usV176rJE/+JCoIK6B1oZaxhciUdDOECaGTFFreIzjU7gALrMcdk
 Auzu6xsWH1s60ByQIr+Auy/5X0w/l5Un3hxKT0icociEtZtZFLwk23HuM1duHY+MkYIiCu4yqQrt
 /leC22QnVTZm9zBZJMYrVJvcY6yTrHnt87bFnWD5oUPIcZgyIs8WFUd+haQNOoPnac1LBl2rjw51
 DPCKUH5YzwdOdLYICJ6X1vGRVUQ01/r3Gm/95cCkyzP6TOSt2bZOVMLAS0Trxqp2VsBZmbaXd0YO
 /0PuvaIDMDve/ityUlSwZOz+4KEcto4nkEHlI6S0H/YnfEGZZ2WKzvvEe0uuyIgD+uS5UfNMSoSj
 bHH4y4Ee49FfqZSD9NP1n4CdV16HebKrcDUovFEOn5dqXs8RoGZlWd6Dyc5ZACdBLqNxNLqNw8eq
 hjqqg4LCpGjIsUDRnuFIo+zb90qJuwuVqtRTTWk6Oa5q8vlqB0l3gsvrfDPYGIfzjmB551X7vOON
 VLUYpt0+jSosX63vKjw7ROEMnvttfgj93Pvk9DLCb18U746uImOm+z1zYTbU9CDyUOVQRqa+0uto
 QDK5ykFrgmwkl38pkgK8egJh6Bj/nQAAFgVXxd
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-OQ-MSGID: <c16-f2fs-nat-ino-mismatch-20261103@qq.com>
Date: Tue, 03 Nov 2026 14:30:00 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 5.2 (+++++)
X-VA-Spam-Flag: YES
X-Headers-End: 1xOIjj-000000003yf-2n0X
Subject: [f2fs-dev] [SPAM] f2fs: missing cross-check between NAT entry ino
 and recovered node footer ino in do_recover_data() - kernel BUG at mount
 with CONFIG_F2FS_CHECK_FS
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
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Mounting a crafted f2fs image ends in a kernel BUG during fsync data
recovery, before any syscall beyond mount():

  F2FS-fs (vda): f2fs_recover_fsync_data: recovery fsync data, check_only: 0
  F2FS-fs (vda): do_recover_data: start to recover dnode
  kernel BUG at fs/f2fs/recovery.c:696!
  RIP: 0010:f2fs_recover_fsync_data+0x7ce6/0x9730
  Kernel panic - not syncing: Fatal exception

The BUG is the f2fs_bug_on() at fs/f2fs/recovery.c:698:

  err = f2fs_get_node_info(sbi, dn.nid, &ni, false);
  if (err)
          goto err;

  f2fs_bug_on(sbi, ni.ino != ino_of_node(sbi, entry));

ni.ino comes from the NAT, ino_of_node() from the node page footer being
recovered. The two values are read from independent on-disk structures
and nothing on the way to the assertion cross-checks them:

  f2fs_get_node_info()    validates only the blk_addr range
  __get_node_page()       validates nid == footer.nid only
  do_read_inode()         no ino cross-check either

So a NAT entry whose ino disagrees with the footer ino of the node the
NAT points at reaches the assertion, which is BUG_ON() under
CONFIG_F2FS_CHECK_FS.

## The two configurations behave differently

Under CONFIG_F2FS_CHECK_FS this is a kernel BUG at mount time. Without
it, f2fs_bug_on() degrades to WARN_ON(1) plus SBI_NEED_FSCK, and
do_recover_data() then proceeds to

  fill_node_footer(sbi, dn.node_entry, dn.nid, ni.ino, ...);

at recovery.c:790 - the NAT's wrong ino is written into the recovered
node's footer. On a production configuration the same input does not
crash; it silently stamps inconsistent metadata into the node page.
The missing cross-check is identical in both configurations.

## The ofs_of_node case was already fixed; the ino case was not

In 2018, a crafted image triggering do_recover_data() through an
inconsistent ofs_of_node was reported (bugzilla 203227) and fixed by
22d61e286e2d ("f2fs: fix to avoid panic in do_recover_data()"): the
ofs mismatch is handled today by the f2fs_warn() + -EFSCORRUPTED +
ERROR_INCONSISTENT_FOOTER path directly below this assertion.

The ino mismatch at the line above it was left as f2fs_bug_on(). It is
the same class of inconsistency, read from the same kind of
independently crafted on-disk state, in the same function, and it still
takes the whole kernel down.

f2fs_sanity_check_node_footer() (node.c:1545) added later checks
nid and the inode/xattr type combination, but not ino either.

## Suggested fix

Treat the ino mismatch the same way the ofs mismatch next to it is
already treated:

  -       f2fs_bug_on(sbi, ni.ino != ino_of_node(sbi, entry));
  +       if (ni.ino != ino_of_node(sbi, entry)) {
  +               f2fs_warn(sbi, "Inconsistent ino_of_node, ino:%llu, nid:%lu, %u",
  +                         inode->i_ino, dn.nid, ino_of_node(sbi, entry));
  +               err = -EFSCORRUPTED;
  +               f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
  +               goto err;
  +       }

Notes on reproduction that matter: the crafted state needs the
checkpoint version raised and the checkpoint checksums recomputed on
both copies (is_recoverable_dnode() requires the footer cp_ver to match),
and the NAT journal entry has to be updated rather than the NAT page
copies alone, since the journal takes precedence during lookup.

The reproducer (image builder, forged checkpoint/NAT builder, ready-made
image, crash log) is available on request.

Tested on 7.3.0 with CONFIG_F2FS_CHECK_FS=y, deterministic 3/3; the
assertion and the surrounding recovery path are unchanged in current
mainline.

Thanks,
Guikun Yang



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
