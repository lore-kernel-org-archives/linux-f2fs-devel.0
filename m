Return-Path: <SRS0=dEys=UX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1593DC43613
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Jun 2019 16:38:05 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54BA20665;
	Mon, 24 Jun 2019 16:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="PDgYtUYC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ErQyxqiX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Val/xFIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54BA20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hfRyd-00082c-68; Mon, 24 Jun 2019 16:37:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <darrick.wong@oracle.com>) id 1hfRyc-00082Q-8g
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Jun 2019 16:37:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HA99AMTfTSc28plQQ/cp41x7Nn4dwb3FKNRresvoez8=; b=PDgYtUYC1iByf2iepeocHUdesH
 4LeSYmyjZjIpbB3ap6NkSMxZnUjhOmDU7/gQoJygZ0RZLdgxsPHj4kGQWsv3yaEYbU4QkVAGtauMS
 ZfrFLkiWDfy2tVErc8Xb7RRV4RL6XiNpM/m8EBJaHe2Sn59//nRnCzfOBtKvkBNxCl/U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HA99AMTfTSc28plQQ/cp41x7Nn4dwb3FKNRresvoez8=; b=ErQyxqiXg+BWbisDVShjYGnc4M
 Xp5kQ3TCsaAk22IFsN9QPL1RgVl38ZnupaDBN1Hxaj5LVFCXGoLqzuGohrN526Y/ZQysCS8HZoOnp
 EJ+E8VTBO5lJd9+68vEK2A+Pqenf0BO1PZwSKQp1lG1QFBVvOrhSOFANDFNSuFeQuygM=;
Received: from userp2120.oracle.com ([156.151.31.85])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hfRyj-00CIov-S2
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Jun 2019 16:38:03 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OGYBIm140014;
 Mon, 24 Jun 2019 16:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=HA99AMTfTSc28plQQ/cp41x7Nn4dwb3FKNRresvoez8=;
 b=Val/xFIcmXfnvXdGrQBd2uUMZYObEi3W8WIlY6oMUJIKvjldL9xYJIbr4X8m/8PfUkNP
 RhH7NFaRejnXOwK4OrHcHI49LEDw30Z0srM0V+BtgIV6OV/ooJ8YuV1XwJC9gXt//xWz
 Q0bSRiqdmELhNdVSkCIZr87TrKLwiGMPLZJNCBd7weSod/LyeYSIITLeuy/oyb0/36Pk
 joZS32wTTBm4Xftsq9fhk9nHXmjGPPxMMMzommCPqRpU1cRv8ZoyAI6/8dXnLZ2krssP
 nfR6QpxDK+AWnV/OvlFkpdglsTrJTTQAP82qwXJGdU82OAjIBZeAn2VIxNce6Btsj8Q4 7Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2t9cyq7dxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Jun 2019 16:36:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OGZS5o040090;
 Mon, 24 Jun 2019 16:36:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by aserp3030.oracle.com with ESMTP id 2t9acbktrd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 24 Jun 2019 16:36:51 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5OGaodY042889;
 Mon, 24 Jun 2019 16:36:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2t9acbktr8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Jun 2019 16:36:50 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5OGaiFC016783;
 Mon, 24 Jun 2019 16:36:44 GMT
Received: from localhost (/67.169.218.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Jun 2019 09:36:44 -0700
Date: Mon, 24 Jun 2019 09:36:42 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Jan Kara <jack@suse.cz>
Message-ID: <20190624163642.GT5387@magnolia>
References: <156116141046.1664939.11424021489724835645.stgit@magnolia>
 <156116142734.1664939.5074567130774423066.stgit@magnolia>
 <20190624153358.GH32376@quack2.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190624153358.GH32376@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=682 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240131
X-Headers-End: 1hfRyj-00CIov-S2
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

On Mon, Jun 24, 2019 at 05:33:58PM +0200, Jan Kara wrote:
> On Fri 21-06-19 16:57:07, Darrick J. Wong wrote:
> > +/*
> > + * Flush file data before changing attributes.  Caller must hold any locks
> > + * required to prevent further writes to this file until we're done setting
> > + * flags.
> > + */
> > +static inline int inode_flush_data(struct inode *inode)
> > +{
> > +	inode_dio_wait(inode);
> > +	return filemap_write_and_wait(inode->i_mapping);
> > +}
> 
> BTW, how about calling this function inode_drain_writes() instead? The
> 'flush_data' part is more a detail of implementation of write draining than
> what we need to do to set immutable flag.

Ok, that's a much better description of what the function does.

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
