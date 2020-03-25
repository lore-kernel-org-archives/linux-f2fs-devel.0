Return-Path: <SRS0=re5T=5K=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEB2C54FCF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:48:36 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 761F620719;
	Wed, 25 Mar 2020 15:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="hfLZJRXU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="GBBjGcPT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pJ8zlWqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761F620719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jH8Gg-0002jC-Fg; Wed, 25 Mar 2020 15:48:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <darrick.wong@oracle.com>) id 1jH8Gf-0002iv-HS
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Mar 2020 15:48:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SAhuJYR710p9035w14LFCCs14DBmQBIGmdL9bTUUots=; b=hfLZJRXUfI55rhLHuoZ+wrKDbn
 EA+flMlvpNpPUzrppziWiC+c46vAlwL9QmKScwv56VblkWIZP35ZIwATxoLb6OTxZDAm+o1VWAIWl
 qro6tEtCUY0TWhkX2fd52qHhQ0Ijhq+KmC+KwzUgEoTWhmMPwblgwY+JLbmlc5TGIR+4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SAhuJYR710p9035w14LFCCs14DBmQBIGmdL9bTUUots=; b=GBBjGcPT5ryDupD5F1/DNJu7T/
 +XAvCYrCYo6y2i+jtm0jaimar5+lWYDkAs9kLfr/80KoC5jgFeX9kEdBhuMJWeO3GQruA+5t7acwP
 /hXosoX0FaPN3oNRX3ucSe3LgytfAxGtynqW/C5aCJFIv9wQgRGOIJGWtsBEicnhvs2o=;
Received: from userp2130.oracle.com ([156.151.31.86])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jH8Gd-0035ht-RN
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Mar 2020 15:48:33 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PFhWTn138528;
 Wed, 25 Mar 2020 15:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=SAhuJYR710p9035w14LFCCs14DBmQBIGmdL9bTUUots=;
 b=pJ8zlWquaVuBZlCEiRCKVOEgaH2EeKEOTDqosmtB3Oeyxj2rlz2NLH1X513eBLxFnT0P
 jbrgO31FDcc5QDUa9nrbWXTX+k70fRRANxJ42/rwUbqWLBYTlawkVtviQ/i4uvg+VxrT
 zRXxAwfKtzIuCMhFws2yah6H/IR3Rqjv5Ontxhonxagx/yNXJUGG3gzOuc4H6O+5QIux
 u3PTZfgAX0PN4hj0GWFAgyHq8kf+2v/QV3ACAD0YYOTZIUEIVCHYKmNRwThCVVTJXEQg
 7XrPWvlK9a397dJjuqM88SxLpuQ+2qdje2a0qscWlUv/BTfDTXUAgurtxyHMZUmcdgbQ Mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2ywabrahka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2020 15:48:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PFke2o113260;
 Wed, 25 Mar 2020 15:48:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 30073ag7t6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2020 15:48:04 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02PFm1WO015355;
 Wed, 25 Mar 2020 15:48:01 GMT
Received: from localhost (/67.169.218.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 25 Mar 2020 08:48:00 -0700
Date: Wed, 25 Mar 2020 08:47:59 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Message-ID: <20200325154759.GY29339@magnolia>
References: <20200320024639.GH1067245@mit.edu>
 <20200320025255.1705972-1-tytso@mit.edu>
 <20200325092057.GA25483@infradead.org>
 <20200325152113.GK53396@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200325152113.GK53396@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250125
X-Headers-End: 1jH8Gd-0035ht-RN
Subject: Re: [f2fs-dev] [PATCH 1/2] writeback: avoid double-writing the
 inode on a lazytime expiration
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
Cc: linux-xfs@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
 Richard Weinberger <richard@nod.at>, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Mar 25, 2020 at 11:21:13AM -0400, Theodore Y. Ts'o wrote:
> On Wed, Mar 25, 2020 at 02:20:57AM -0700, Christoph Hellwig wrote:
> > >  	spin_unlock(&inode->i_lock);
> > >  
> > > -	if (dirty & I_DIRTY_TIME)
> > > -		mark_inode_dirty_sync(inode);
> > > +	/* This was a lazytime expiration; we need to tell the file system */
> > > +	if (dirty & I_DIRTY_TIME_EXPIRED && inode->i_sb->s_op->dirty_inode)
> > > +		inode->i_sb->s_op->dirty_inode(inode, I_DIRTY_SYNC);
> > 
> > I think this needs a very clear comment explaining why we don't go
> > through __mark_inode_dirty.
> 
> I can take the explanation which is in the git commit description and
> move it into the comment.
> 
> > But as said before I'd rather have a new lazytime_expired operation that
> > makes it very clear what is happening.  We currenly have 4 file systems
> > (ext4, f2fs, ubifs and xfs) that support lazytime, so this won't really
> > be a major churn.
> 
> Again, I believe patch #2 does what you want; if it doesn't can you
> explain why passing I_DIRTY_TIME_EXPIRED to s_op->dirty_inode() isn't
> "a new lazytime expired operation that makes very clear what is
> happening"?
> 
> I separated out patch #1 and patch #2 because patch #1 preserves
> current behavior, and patch #2 modifies XFS code, which I don't want
> to push Linus without an XFS reviewed-by.
> 
> N.b.  None of the other file systems required a change for patch #2,
> so if you want, we can have the XFS tree carry patch #2, and/or
> combine that with whatever other simplifying changes that you want.
> Or I can combine patch #1 and patch #2, with an XFS Reviewed-by, and
> send it through the ext4 tree.
> 
> What's your pleasure?

TBH while I'm pretty sure this does actually maintain more or less the
same behavior on xfs, I prefer Christoph's explicit ->lazytime_expired
approach[1] over squinting at bitflag manipulations.

(It also took me a while to realize that this patch duo even existed, as
it was kinda buried in its parent thread...)

--D

[1] https://lore.kernel.org/linux-fsdevel/20200325122825.1086872-1-hch@lst.de/T/#t

> 
> 					- Ted
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
