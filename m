Return-Path: <SRS0=dEys=UX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732A4C4646C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:34 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B4320665;
	Mon, 24 Jun 2019 21:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="NR6fEy78";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="UWNJ1Yj8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vwSceTOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B4320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hfWzm-0003jB-Qn; Mon, 24 Jun 2019 21:59:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <darrick.wong@oracle.com>) id 1hfWzl-0003j2-Fm
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Jun 2019 21:59:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JPBEqrnBb8FJilUCQCUmMJhL0pO+qsW2uzegjGEHDYQ=; b=NR6fEy78KwXVF4J+D2NLV7vATi
 6MBY/jB9ssLU0M1UbLdfaXqCDQ2OfaAVa+iyM+F5+zSzNxBEqXU6ozRkCSkBKoigPeD/LiHcXgygo
 yMoC39GPObNHBOjHXqb6LrQfindUQf1admIclwfxCIXxS1m2Lb+0N3h0Iv7zR4KkaJYs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JPBEqrnBb8FJilUCQCUmMJhL0pO+qsW2uzegjGEHDYQ=; b=UWNJ1Yj8dDf+kMljoLKhqJNNkO
 pbfidG0aUgRAsURToC72ImUgwYEdJxd0yFSBbmfNDjMk4Dzkb4+18qxJA7cnm5541WifQ5ij1/ilB
 S6RwsOGS278kOYxVDXZsGxtnXm4m/IwiqVoCj/CGuJGfnOKq37zQrTDK4xXX2mkyI5Wo=;
Received: from aserp2120.oracle.com ([141.146.126.78])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hfWzq-00CHSp-1i
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Jun 2019 21:59:31 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OLsca6091939;
 Mon, 24 Jun 2019 21:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=JPBEqrnBb8FJilUCQCUmMJhL0pO+qsW2uzegjGEHDYQ=;
 b=vwSceTOFPnndaHyinJXnA0XxpMTF4zGHNj5lEs+w8XWiVL6ly7Z9VEVjJV4gnFgKkKwW
 B8SdZ4krsyR6f1E0FlYW5moxuEmjhgn85HtSg0z2oOp1hhMJdo3XOqpiHvEil1BlZ2KW
 PEGmAIadWWqhl9+AmMr5FDs139rF0no0szY6ZnskKVnUEMSG9PrJ5dCsFbIdJrY2zxiP
 3z4yfqHwUSqvLrreOnH+MDuEMhE8ElZOtQ8shgvbsZ/7FCLrYScc7NOmLBxChFYSaq/u
 gI1Rn+l+GOiLbqZED3Z1Od5UlWcckpvKqSJxtGUwwy+7uAnIrP4j5qb9NqSYBMPprys8 Qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2t9c9pgrf7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Jun 2019 21:58:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OLwP9j160075;
 Mon, 24 Jun 2019 21:58:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3020.oracle.com with ESMTP id 2tat7bvjfc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 24 Jun 2019 21:58:28 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5OLwS3d160108;
 Mon, 24 Jun 2019 21:58:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2tat7bvjf7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Jun 2019 21:58:28 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5OLwK6v015219;
 Mon, 24 Jun 2019 21:58:20 GMT
Received: from localhost (/67.169.218.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Jun 2019 14:58:20 -0700
Date: Mon, 24 Jun 2019 14:58:17 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Jan Kara <jack@suse.cz>
Message-ID: <20190624215817.GE1611011@magnolia>
References: <156116141046.1664939.11424021489724835645.stgit@magnolia>
 <156116142734.1664939.5074567130774423066.stgit@magnolia>
 <20190624113737.GG32376@quack2.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190624113737.GG32376@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=805 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240172
X-Headers-End: 1hfWzq-00CHSp-1i
Subject: Re: [f2fs-dev] [PATCH 2/7] vfs: flush and wait for io when setting
 the immutable flag via SETFLAGS
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
Cc: linux-efi@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
 clm@fb.com, adilger.kernel@dilger.ca, matthew.garrett@nebula.com,
 linux-nilfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 devel@lists.orangefs.org, josef@toxicpanda.com, reiserfs-devel@vger.kernel.org,
 viro@zeniv.linux.org.uk, dsterba@suse.com, jaegeuk@kernel.org, tytso@mit.edu,
 ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 jk@ozlabs.org, jack@suse.com, linux-fsdevel@vger.kernel.org,
 linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jun 24, 2019 at 01:37:37PM +0200, Jan Kara wrote:
> On Fri 21-06-19 16:57:07, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > When we're using FS_IOC_SETFLAGS to set the immutable flag on a file, we
> > need to ensure that userspace can't continue to write the file after the
> > file becomes immutable.  To make that happen, we have to flush all the
> > dirty pagecache pages to disk to ensure that we can fail a page fault on
> > a mmap'd region, wait for pending directio to complete, and hope the
> > caller locked out any new writes by holding the inode lock.
> > 
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Seeing the way this worked out, is there a reason to have separate
> vfs_ioc_setflags_flush_data() instead of folding the functionality in
> vfs_ioc_setflags_check() (possibly renaming it to
> vfs_ioc_setflags_prepare() to indicate it does already some changes)? I
> don't see any place that would need these two separated...

XFS needs them to be separated.

If we even /think/ that we're going to be setting the immutable flag
then we need to grab the IOLOCK and the MMAPLOCK to prevent further
writes while we drain all the directio writes and dirty data.  IO
completions for the write draining can take the ILOCK, which means that
we can't have grabbed it yet.

Next, we grab the ILOCK so we can check the new flags against the inode
and then update the inode core.

For most filesystems I think it suffices to inode_lock and then do both,
though.

> > +/*
> > + * Flush all pending IO and dirty mappings before setting S_IMMUTABLE on an
> > + * inode via FS_IOC_SETFLAGS.  If the flush fails we'll clear the flag before
> > + * returning error.
> > + *
> > + * Note: the caller should be holding i_mutex, or else be sure that
> > + * they have exclusive access to the inode structure.
> > + */
> > +static inline int vfs_ioc_setflags_flush_data(struct inode *inode, int flags)
> > +{
> > +	int ret;
> > +
> > +	if (!vfs_ioc_setflags_need_flush(inode, flags))
> > +		return 0;
> > +
> > +	inode_set_flags(inode, S_IMMUTABLE, S_IMMUTABLE);
> > +	ret = inode_flush_data(inode);
> > +	if (ret)
> > +		inode_set_flags(inode, 0, S_IMMUTABLE);
> > +	return ret;
> > +}
> 
> Also this sets S_IMMUTABLE whenever vfs_ioc_setflags_need_flush() returns
> true. That is currently the right thing but seems like a landmine waiting
> to trip? So I'd just drop the vfs_ioc_setflags_need_flush() abstraction to
> make it clear what's going on.

Ok.

--D

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
