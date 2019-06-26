Return-Path: <SRS0=M3qu=UZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3483BC48BD3
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Jun 2019 15:31:22 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BD021726;
	Wed, 26 Jun 2019 15:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="hSShC87q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="iRnzKPFO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5SsxtbAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BD021726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hg9t6-0006KA-Cf; Wed, 26 Jun 2019 15:31:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <darrick.wong@oracle.com>)
 id 1hg9t4-0006JU-Vg; Wed, 26 Jun 2019 15:31:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YDGFAgA+UzOeA0RzbEZlqh20naHwE1ADD0yDq6Je8dw=; b=hSShC87qrgJx2VdGGPVh6Pq27W
 pw1h2UPGPr6GHc0mpC0UwGiGBf4l5KjhaVlJ+INM8/H2NbEaUlOqMYFmCcO/yQxy+2Ril2/sFJ+nH
 ZPiD1S81IS/18jq0nZd/VIbkTkCeY9GSjRD045lxzIxCj+qUVsms1LtpPWBVTB58Rsro=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YDGFAgA+UzOeA0RzbEZlqh20naHwE1ADD0yDq6Je8dw=; b=iRnzKPFOn5Eni0LsVfZ5O+I7Ck
 e/EYsInEyLHgsED40wlogFltVqFeOFh2Plv5QyiOqWOSBy5kM7WBQYnLlZ86+OLQ07UlUYA5D8wtM
 Icd29yO9W/ypnxq7m/r6pyGeKdveKEFQYWPDOWlc7vMerDit0JIdJAPPwtOVnQlqkO68=;
Received: from userp2120.oracle.com ([156.151.31.85])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hg9tG-00EUGf-1Y; Wed, 26 Jun 2019 15:31:19 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QFSnC2152772;
 Wed, 26 Jun 2019 15:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=YDGFAgA+UzOeA0RzbEZlqh20naHwE1ADD0yDq6Je8dw=;
 b=5SsxtbAHYwnkmxJULysm2KxZq5mbde0t3XyhzMeXSwZAo4FZC5HrtAbNxP4iKFNYt/kh
 Y7dWO5SaAbHINxAtS5d9huSJUKZX4sYaTFJweZpJSueupmjWstikFvfvx8fArqJIXvjO
 Fh9JhfPE1NlWZEUQ0i0vMF5uNs2kkXHzSSkRzf28Mylp3bBUyhO5LLLfnkC3dJTCGlix
 DdNr61pg6B1lXISHc2RzFLC5ZVBDGfKB2yuj2p08FMyCBdBANGMe381f0kogMmY2sp3/
 7q+Y/Qa9+RQG0rUGnPnm6o2EIm78XgGS2+4bIC9MSn2e1l50r41/Mdb5HkREd2b4yCqU EA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2t9cyqk123-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 15:30:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QFUlol038904;
 Wed, 26 Jun 2019 15:30:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by aserp3020.oracle.com with ESMTP id 2t9p6uuedy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 26 Jun 2019 15:30:50 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5QFUnfo039268;
 Wed, 26 Jun 2019 15:30:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2t9p6uuedk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 15:30:49 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5QFUdFL030769;
 Wed, 26 Jun 2019 15:30:39 GMT
Received: from localhost (/10.159.137.246)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 26 Jun 2019 08:30:38 -0700
Date: Wed, 26 Jun 2019 08:30:36 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <20190626153036.GD5171@magnolia>
References: <156151632209.2283456.3592379873620132456.stgit@magnolia>
 <156151633004.2283456.4175543089138173586.stgit@magnolia>
 <20190626040202.GA32272@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190626040202.GA32272@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=779 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260181
X-Headers-End: 1hg9tG-00EUGf-1Y
Subject: Re: [f2fs-dev] [PATCH 1/5] vfs: create a generic checking and prep
 function for FS_IOC_SETFLAGS
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
Cc: shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-efi@vger.kernel.org, Jan Kara <jack@suse.cz>, hch@infradead.org,
 linux-btrfs@vger.kernel.org, clm@fb.com, adilger.kernel@dilger.ca,
 Christoph Hellwig <hch@lst.de>, matthew.garrett@nebula.com,
 linux-nilfs@vger.kernel.org, cluster-devel@redhat.com,
 linux-ext4@vger.kernel.org, josef@toxicpanda.com,
 reiserfs-devel@vger.kernel.org, dsterba@suse.com, jaegeuk@kernel.org,
 tytso@mit.edu, ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 jk@ozlabs.org, jack@suse.com, linux-fsdevel@vger.kernel.org,
 linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jun 26, 2019 at 05:02:02AM +0100, Al Viro wrote:
> On Tue, Jun 25, 2019 at 07:32:10PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > Create a generic function to check incoming FS_IOC_SETFLAGS flag values
> > and later prepare the inode for updates so that we can standardize the
> > implementations that follow ext4's flag values.
> 
> Change in efivarfs behaviour deserves a note.  I'm not saying it's wrong,
> but behaviour is changed there - no-op FS_IOC_SETFLAGS used to fail
> without CAP_LINUX_IMMUTABLE...

Ok, will do.  FWIW I wondered about fixing the orangefs usage too (using
an unsigned long uval to hold the contents of an unsigned int coming
from userspace) but ... that's their decision.

--D


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
