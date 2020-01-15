Return-Path: <SRS0=YOv7=3E=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA72C32771
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Jan 2020 17:11:50 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994EF214AF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Jan 2020 17:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="kPDu5tye";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="WhTfVeh+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jGRi57OM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994EF214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1irmCr-0007xP-PP; Wed, 15 Jan 2020 17:11:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <darrick.wong@oracle.com>) id 1irmCq-0007xH-2y
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Jan 2020 17:11:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yodk3FXBxJ+C4bpH8jgyDdNJeLK8BCw4+p/mjjrGu6I=; b=kPDu5tyeRdKocHqEdVx+lWH0EJ
 WniIiuwt+g6FAzPiNtlrYhaNeI5av4b6S30GyUA1Xn4lU1gdcpqicoGD0QcKOKoKHl343TlT/YSUb
 bm/91yC6x35sutIw0mG5+FCWsJIHsU5iSvIrNNbSRzt/hUA81FHsInbSuB+0PuuWHGj4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yodk3FXBxJ+C4bpH8jgyDdNJeLK8BCw4+p/mjjrGu6I=; b=WhTfVeh+GkKu4fR6LWQgkgnT+S
 jfzNbF97ruGHvj9im2aZBv5F7FnISNBeTb/aZNHnL5dim5KmhJlYFoAff3OLumZOUoQA28ex3Ps9t
 9WSrTlGXtN1J6rWWoeWTJAxreEa4Sy1s3SGypl3jl22iNA/iPm/kLnuTa/NNsUj9trFs=;
Received: from userp2130.oracle.com ([156.151.31.86])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1irmCk-007gd0-WD
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Jan 2020 17:11:48 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FH9YWk059762;
 Wed, 15 Jan 2020 17:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=yodk3FXBxJ+C4bpH8jgyDdNJeLK8BCw4+p/mjjrGu6I=;
 b=jGRi57OMh1x0TFj3rivWK8oMNmRGnEM26tBEOTsVXZ0KoEYnD+vD+kUfJC7N9Q9hKrY9
 FyQSIcaoLmNanRUrwVSx2oCpicHju3dtqFcYg3frf2nv4KVRTXvQ/FD1BMqP4X+kOAk9
 73YoDwwSBCteTcyAYNDjU9jCtrJcmTyz2ycimS7vyFrFZ0ZgPzL03cuxP7VTI/bVwJEy
 FU7LlGBPdez1oPasB/r2kFvgADnC1bUJzk8eMXP/Mx7PPLFr/w7+naEL+Q0YlIbPgGYl
 7dJyRU6jwabybhhkxT+Dl5umB4dU2h3iI3tAm15nW9CAU1KXQJdf2jVWJk8Dy8rjqGxq iA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2xf74sdfnf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2020 17:11:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FH9Xdk073935;
 Wed, 15 Jan 2020 17:11:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2xj1apxkdc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2020 17:11:00 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00FHAopO016173;
 Wed, 15 Jan 2020 17:10:50 GMT
Received: from localhost (/67.169.218.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 15 Jan 2020 09:10:50 -0800
Date: Wed, 15 Jan 2020 09:10:47 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <20200115171047.GA8247@magnolia>
References: <20200108131528.4279-1-agruenba@redhat.com>
 <20200108165710.GA18523@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200108165710.GA18523@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001150130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001150130
X-Headers-End: 1irmCk-007gd0-WD
Subject: Re: [f2fs-dev] [PATCH v4] fs: Fix page_mkwrite off-by-one errors
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
Cc: Jan Kara <jack@suse.cz>, Adrian Hunter <adrian.hunter@intel.com>,
 Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Andreas Gruenbacher <agruenba@redhat.com>, Sage Weil <sage@redhat.com>,
 Richard Weinberger <richard@nod.at>, YueHaibing <yuehaibing@huawei.com>,
 Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Josef Bacik <josef@toxicpanda.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Artem Bityutskiy <dedekind1@gmail.com>,
 Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jan 08, 2020 at 08:57:10AM -0800, Christoph Hellwig wrote:
> I don't want to be the party pooper, but shouldn't this be a series
> with one patch to add the helper, and then once for each fs / piece
> of common code switched over?

The current patch in the iomap branch contains the chunks that add the
helper function, fix iomap, and whatever chunks for other filesystems
that don't cause /any/ merge complaints in for-next.  That means btrfs,
ceph, ext4, and ubifs will get fixed this time around.

Seeing as it's been floating around in for-next for a week now I'd
rather not rebase the branch just to rip out the four parts that haven't
given me any headaches so that they can be applied separately. :)

The acks from the other fs maintainers were very helpful, but at the
same time, I don't want to become a shadow vfs maintainer.

Therefore, whatever's in this v4 patch that isn't in [1] will have to be
sent separately.

[1] https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=iomap-5.6-merge&id=62e298db3fc3ebf41d996f3c86b44cbbdd3286bc

> On Wed, Jan 08, 2020 at 02:15:28PM +0100, Andreas Gruenbacher wrote:
> > Hi Darrick,
> > 
> > here's an updated version with the latest feedback incorporated.  Hope
> > you find that useful.
> > 
> > As far as the f2fs merge conflict goes, I've been told by Linus not to
> > resolve those kinds of conflicts but to point them out when sending the
> > merge request.  So this shouldn't be a big deal.
> 
> Also this isn't really the proper way to write a commit message.  This
> text would go into the cover letter if it was a series..

<urk> Yeah.

--D


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
