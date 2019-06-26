Return-Path: <SRS0=M3qu=UZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898DCC48BD5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Jun 2019 02:34:15 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DCF82085A;
	Wed, 26 Jun 2019 02:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="j2cjkxoF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="fekzI9pt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G/aYnUXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCF82085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hfxl5-00027p-Jp; Wed, 26 Jun 2019 02:34:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <darrick.wong@oracle.com>) id 1hfxl3-00027Y-VA
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 Jun 2019 02:34:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Subject:Cc:
 To:From:Date:Message-ID:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fawPQY/UISfSH6DvrztcWabWXm47TtXieQJWSELxOKQ=; b=j2cjkxoFAOL8SNR/WC+V/aIybm
 5VltKr89MjNZ1T8pSssQCQoJzV0Gfh5H5bK3/iy2zlghFqtn/VWUJxs8ptpedR3u2Ufs4z+m5h2Hx
 mc6pn3neWDYzLKtJwcbAMHtJmdGhL2Wk666yB8cp9dNhvK/2bJpyBsfcRoKuD2BT8AUk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Subject:Cc:To:From:Date:Message-ID
 :MIME-Version:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fawPQY/UISfSH6DvrztcWabWXm47TtXieQJWSELxOKQ=; b=f
 ekzI9ptIOhdFSjNviuEKvDLL/yO/nhkUYhLysyfmjOZbmc8LTdLtl/cvWzS6G0n3A7B4i68vhIhtJ
 85K/+hiRhS7Qb19g8VLhxh6UuXCA+JcQzpSN9BcssgQAkszceVtDH0vYgdtTBU/ZKOBgHyu41mNFi
 tgNqB5EUaDB0ueDc=;
Received: from aserp2120.oracle.com ([141.146.126.78])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hfxlD-00EEF7-Aa
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 Jun 2019 02:34:13 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q2TYh8026692;
 Wed, 26 Jun 2019 02:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=fawPQY/UISfSH6DvrztcWabWXm47TtXieQJWSELxOKQ=;
 b=G/aYnUXEphMoz0tS57JlzzJidDTnCP3JwQDBotgjzdUejbyDPYJP0ww7UIoJ9qziXtze
 V8WfKNQm07ANAuCm8B36a/SSrlnF4iTQcfj6+NLwHRqJVTP47OZew3gQAlm23ALl0Umk
 xq3Im7dO6UOb8iISWt8zfUFMNhrviliNGlkVCg5a0cfeb27h0Drq5G4rl1p6MZONDA9T
 LOJ0700Z6AtHwS+rK56pnb/hADrt/VxtC4zKanyLYIE10jvKJ1zJCdEbZq2d2Ps/KjeI
 pOTljCBSvtHNdPtMRfVj73W2qgv94B8p+0UE9rS1oOhD12Oac8PGEIcskWt9iHiUUTuy 2A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2t9c9pqjk5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 02:33:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q2Wj2o020612;
 Wed, 26 Jun 2019 02:33:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by aserp3020.oracle.com with ESMTP id 2t9p6uh2eh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 26 Jun 2019 02:33:07 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5Q2X7If021156;
 Wed, 26 Jun 2019 02:33:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2t9p6uh2ec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 02:33:07 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5Q2X6O7021146;
 Wed, 26 Jun 2019 02:33:06 GMT
Received: from localhost (/10.159.230.235) by default (Oracle Beehive Gateway
 v4.0) with ESMTP ; Tue, 25 Jun 2019 19:32:55 -0700
USER-AGENT: StGit/0.17.1-dirty
MIME-Version: 1.0
Message-ID: <156151637248.2283603.8458727861336380714.stgit@magnolia>
Date: Tue, 25 Jun 2019 19:32:52 -0700 (PDT)
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
 darrick.wong@oracle.com, ard.biesheuvel@linaro.org,
 josef@toxicpanda.com, hch@infradead.org, clm@fb.com,
 adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk, jack@suse.com,
 dsterba@suse.com, jaegeuk@kernel.org, jk@ozlabs.org
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260027
X-Headers-End: 1hfxlD-00EEF7-Aa
Subject: [f2fs-dev] [PATCH v5 0/5] vfs: make immutable files actually
 immutable
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
Cc: linux-efi@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-nilfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, devel@lists.orangefs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi all,

The chattr(1) manpage has this to say about the immutable bit that
system administrators can set on files:

"A file with the 'i' attribute cannot be modified: it cannot be deleted
or renamed, no link can be created to this file, most of the file's
metadata can not be modified, and the file can not be opened in write
mode."

Given the clause about how the file 'cannot be modified', it is
surprising that programs holding writable file descriptors can continue
to write to and truncate files after the immutable flag has been set,
but they cannot call other things such as utimes, fallocate, unlink,
link, setxattr, or reflink.

Since the immutable flag is only settable by administrators, resolve
this inconsistent behavior in favor of the documented behavior -- once
the flag is set, the file cannot be modified, period.  We presume that
administrators must be trusted to know what they're doing, and that
cutting off programs with writable fds will probably break them.

Therefore, add immutability checks to the relevant VFS functions, then
refactor the SETFLAGS and FSSETXATTR implementations to use common
argument checking functions so that we can then force pagefaults on all
the file data when setting immutability.

Note that various distro manpages points out the inconsistent behavior
of the various Linux filesystems w.r.t. immutable.  This fixes all that.

I also discovered that userspace programs can write and create writable
memory mappings to active swap files.  This is extremely bad because
this allows anyone with write privileges to corrupt system memory.  The
final patch in this series closes off that hole, at least for swap
files.

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This has been lightly tested with fstests.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=immutable-files

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=immutable-files


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
