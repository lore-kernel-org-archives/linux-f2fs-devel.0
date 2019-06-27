Return-Path: <SRS0=+JY/=U2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289A5C48BD6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Jun 2019 00:22:29 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22FE20815;
	Thu, 27 Jun 2019 00:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="HhOO0X6L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Tagq4f6+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nB7qaexU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22FE20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hgIBC-000879-Kp; Thu, 27 Jun 2019 00:22:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <darrick.wong@oracle.com>)
 id 1hgIBB-00086q-7S; Thu, 27 Jun 2019 00:22:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OZ6e0FbvZ6ih1IklP3kOWEbcdJlaHfvXLF3leRVcWUY=; b=HhOO0X6LdUu2zIZfMLWyFP0mwy
 CjQVuXbLAkUMbRtNMRS7o/7/6iV38zFLZMFiQejjdKVQBRBBhw8blFpv/pCKrCFr92eN6isqvDnUw
 UHB2aGcBPS1kk/rRSY6sTgFTVtPTcB8hK+uCqB1CsMLhjCSQxIFV/qTUMhpgxgA7lIbA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OZ6e0FbvZ6ih1IklP3kOWEbcdJlaHfvXLF3leRVcWUY=; b=Tagq4f6+q+lBwyLZNNa6SRATYB
 R1IpSRzP0brrXrPmegTZfWDtL8Zz5v0XL0ht1B5bXV1NtfS0ynGBabtl1k7YYmXjKKw4lZRkyekm2
 BwqWiYQkj6ePAD6GtZ6UkeiAxF9ez3saD56G1BRBvk7bHFhGptizYnA79OfpHisoj6eU=;
Received: from userp2130.oracle.com ([156.151.31.86])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hgIBD-00CE3x-Gu; Thu, 27 Jun 2019 00:22:26 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R095sZ153911;
 Thu, 27 Jun 2019 00:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=OZ6e0FbvZ6ih1IklP3kOWEbcdJlaHfvXLF3leRVcWUY=;
 b=nB7qaexUVLsnWtZZL8ilmpxLc4CbV8CD4zkMKrWoh3xml3JhUaIp9+OiX8KWgEiq+QTV
 TmxH5cPDR/GN/Mim9pS0HSeUZriivu5IXjKymJeB4VlwuYqux8YFE96Q7ZuFaywS9GAs
 IfOynDYAH9wgXQWBBSy6D0VCSg6NmF9n/ECyAKjhrIbHx+AeA7tGFvV0wlMxz0hVhnnB
 xmxNQ5IUCjtH5vC5g7w5I84m4u6ESWlV3qRYMg8v1xYN3YBxl87OiOZnnvitl0kRmOQG
 ZRsajauz8/ilsNemW/ld4kcCe0+NXHIqitakDgA0iOejAf6kjQWlHHswxg9S0B9x2R/i YA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2t9brtd8qm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Jun 2019 00:21:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R0I1KJ030470;
 Thu, 27 Jun 2019 00:19:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3030.oracle.com with ESMTP id 2t99f4r2nb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Jun 2019 00:19:34 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5R0JYLu032344;
 Thu, 27 Jun 2019 00:19:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2t99f4r2n4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Jun 2019 00:19:34 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5R0JTqS006644;
 Thu, 27 Jun 2019 00:19:29 GMT
Received: from localhost (/10.145.178.41)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 26 Jun 2019 17:19:28 -0700
Date: Wed, 26 Jun 2019 17:19:26 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <20190627001926.GL5171@magnolia>
References: <156151632209.2283456.3592379873620132456.stgit@magnolia>
 <156151633829.2283456.834142172527987802.stgit@magnolia>
 <20190626041133.GB32272@ZenIV.linux.org.uk>
 <20190626153542.GE5171@magnolia>
 <20190626154302.GA31445@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190626154302.GA31445@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270000
X-Headers-End: 1hgIBD-00CE3x-Gu
Subject: Re: [f2fs-dev] [PATCH 2/5] vfs: create a generic checking function
 for FS_IOC_FSSETXATTR
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
 linux-efi@vger.kernel.org, Jan Kara <jack@suse.cz>,
 linux-btrfs@vger.kernel.org, clm@fb.com, adilger.kernel@dilger.ca,
 matthew.garrett@nebula.com, linux-nilfs@vger.kernel.org,
 cluster-devel@redhat.com, linux-ext4@vger.kernel.org, josef@toxicpanda.com,
 reiserfs-devel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 dsterba@suse.com, jaegeuk@kernel.org, tytso@mit.edu, ard.biesheuvel@linaro.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, jk@ozlabs.org, jack@suse.com,
 linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
 ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jun 26, 2019 at 08:43:02AM -0700, Christoph Hellwig wrote:
> On Wed, Jun 26, 2019 at 08:35:42AM -0700, Darrick J. Wong wrote:
> > > static inline void simple_fill_fsxattr(struct fsxattr *fa, unsigned xflags)
> > > {
> > > 	memset(fa, 0, sizeof(*fa));
> > > 	fa->fsx_xflags = xflags;
> > > }
> > > 
> > > and let the compiler optimize the crap out?
> > 
> > The v2 series used to do that, but Christoph complained that having a
> > helper for a two-line memset and initialization was silly[1] so now we
> > have this version.
> > 
> > I don't mind reinstating it as a static inline helper, but I'd like some
> > input from any of the btrfs developers (or you, Al) about which form is
> > preferred.
> 
> I complained having that helper in btrfs.  I think Al wants a generic
> one, which at least makes a little more sense.

Ok.

> That being said I wonder if we should lift these attr ioctls to
> file op methods and deal with all that crap in VFS code instead of
> having all those duplicated ioctl parsers.

That sounds like an excellent next patchset. :)

--D


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
