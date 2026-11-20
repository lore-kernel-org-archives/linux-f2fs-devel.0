Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD76606A6E5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ln+Dmokx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fr3T9oWo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HXakTLRZ;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=aL9MW1VA;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=mNQLJKUI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=9felQalxRAAUpTsbjvANYlKY9fCNRkaPukhxdCwIakM=; b=ln+Dmokx/0FgXdme430Rp2OJa+
	uvoCq8YT6gXPVr2c+u60N5cYLnGkxTtrxVFK4jGpsqExABY5C9W1eToZwUMwIheGYobI55lZZLEh9
	ww6bRFRULWDmKF5onQmUvRkRFaghZWzwGpVbJWEk2cukVAQ22BMa8gIzr7Ocq702AXKc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCf-000000000YS-1mpR;
	Fri, 20 Nov 2026 19:23:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCZ-000000000WY-2OHC
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WpxxhQdEk0e5hKJddUVsZdLAqoHpjCsCTPG2BBiHUcg=; b=fr3T9oWoJEmHeKaMvayj/0U9kv
 UC/6dTugDYqqHq7Ku4AJJPhLuJv61xqxL2SDFZnomro5dWu1roHCk2qLiPf57ozpCQM9ajhbInLxu
 IwDUCphXIwrRqv5nZ0TJ6ntQ5AuG82jXcMqyAsxBlB8395kSu4B11kk9T8PD9gm2YZwQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WpxxhQdEk0e5hKJddUVsZdLAqoHpjCsCTPG2BBiHUcg=; b=HXakTLRZqlrlDSqWrXadIRkCiF
 4OVQMHWG9kNH7s/7/Ibr8SgfzhXgz3xcEfl8F+pBHJrIOTbyhUZYLmLn1TfuCwwkvVw8xovOuK9FC
 MzClS3a16DK80R9O9IWxc9mUQYVmgJTKFZW9o2ZZnaKamJRcCV3hTJSkRbCTcr+/hJ/U=;
Received: from mx0a-00364e01.pphosted.com ([148.163.135.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCZ-0000000018b-09XI
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:15 +0000
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
 by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIv30n1233418
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=Wpxx
 hQdEk0e5hKJddUVsZdLAqoHpjCsCTPG2BBiHUcg=; b=aL9MW1VA1qbAbZTKX+AY
 2LcYz61krwXyV89zrYYcQOttVwZYv4WslLexOw0TEEb/4J2ZLvxl5cKsgyoaZrLw
 7ct2pSOEp+XGdnQcVQL0QJlD0itn2H6ct3zGCQz0mPT5Er8Swtb7qDJf9iLBN0GE
 7XUWoG119rN7t8E16W8l5zIcDDLbq6DIsMFMp9K9EmJVjqeN2RMsym7vr3o32L+0
 PwQG7dRa8cWAces/pbN7QQm1fe9hig5Hrw58XaPsK/Hk7UfwHg1nKtQNxUvZuig8
 pCP0TEcEmTsiudrXljJBNELGs0kzlQQ0dFZarOKG1yVonTAgjPW4VQuzzyQuaksh
 dA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j2u698mg7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:23:09 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-92109408212so26770846d6.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202588; x=1795807388;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WpxxhQdEk0e5hKJddUVsZdLAqoHpjCsCTPG2BBiHUcg=;
 b=mNQLJKUI4eI17btbKbs7Cxh1WKijruZJZEYv/tUiB1BB/c251nfKLs8C6kz0fODVuM
 1VK7BTo4UKarezbKjaPQPCpDOaqVhMRk6Jqxf6KQ5W3JLCdsgr2INtYNMjGZWSxg/HYh
 douBAWVpXuwzOnAC7IQYYq+o4jpq6EC6cNfUD+dFtLro9HAlwh8ozieMPu6VuWtIDQ3A
 on0Ke4pPW1hr3Xfzg+txv4+pQSLO/1W1sTuLgszPFLVXbLqOAqqHh8iJ8kphz04nc/Do
 eSHh54M9SELlv8EBzPEYYTpioSYh4oIbv88TzunGhMEeO4TbC5lRt0e9QKm73Nbf4Z5I
 dbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202588; x=1795807388;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WpxxhQdEk0e5hKJddUVsZdLAqoHpjCsCTPG2BBiHUcg=;
 b=oliuqI07W6wGHul450CkGiAMYuUKyJvOiC5WNlNEaWOdw8/IOX8FFO3jz3nJHI/Lvp
 RLDg1f6sb6b/0dZY87bkzhWMbLSeyWhFK04tz9OVSc6MM2Kl9zMULUJiOJzgl63P4FXz
 PLXIPTJ5XYf9caEwiQKL7FylQ/xhox/lmiriH3mM8sOrJnEUudBxMLtPCvJZ/PapaZW3
 4GQUn2iv73M9Gk4CvGeDIAn3aDv6sLUaaGS1sIpGSMZ/SsW0+zI22SxcZ/4ZJZt7IVZP
 LYin15+74kXKiC20Y1pBQ/7Qmsdb1YCdAzjP+sEeMQHvOKlGF/fxq7nUoOJB9PzNWj8o
 sudw==
X-Forwarded-Encrypted: i=1;
 AL+hErELQodImDjAPOgcNiZxMAo3/GlpQydSWfM96JXyZjlBlDTIFia7osEqdzdb+d3AdsfuKDBRYSW9cGXRuV9AIhKO@lists.sourceforge.net
X-Gm-Message-State: APuU4Z81zRf8Xhoehtlkpi3jj1vjZ5O59vPtSAp3H8lpVeFR5xiC0Www
 jd2stVgRq6QAd2kH5qjDCGIXKfsjxLn26esaSnee+9B0eiYc8zKRDzPSLbxN2OMlTyXJ66wENHg
 9F0Oi5WyUAsH9B7kbW+YD98+6oA6KWKnT0bYzXRpEJ5kIJ7QDZ7aix5WlliOkRm84DBsgbx61Xk
 MqvphfMrY=
X-Gm-Gg: AZFdTZewqVJQWh6arUmqzbcFxNMvz+KdVLRC6b3kG3pvdT49mqqhWIC60AcjB7MZf5i
 hP+TIzpDAamRv2lFC5w1RGANozHuhHWVIfBbmkRw7uYmVLfjCf0/XQkO1cj5dBEqf0RV6NiDKXq
 3+JYnezYeqb1GAMZhM4/ec0beCDnXZLZ5e8NPygb8uVtJ/SFfLTIv3Rv8qP13oPwhNP02GTBWvy
 c8WiFS4K0Qx/PT7W4RAcauwJNXoZD3YY05losV+ScBq6hSs9JloSVygPk9iP6GtNFnCWO3wux6m
 uwzI5VI6jnHTb9SbRDlWbtsiInJ8vo7VEaj+tEuC7Ufhm9G86pRxoQ7fiw7h/2ijpN7gqrosxGC
 8rTHh/SuiMinbXFMBfKDgKWV0hgQ6bt12H0I/QZzNlzJuvHbS+YMnenBjogHdb1IsM2Nu/Hau0V
 feZp8gmZbOaSHlcLaFPkIv
X-Received: by 2002:a05:6214:2f0d:b0:91e:9d18:6a61 with SMTP id
 6a1803df08f44-921349d1bc2mr71973016d6.5.1795202588234; 
 Fri, 20 Nov 2026 11:23:08 -0800 (PST)
X-Received: by 2002:a05:6214:2f0d:b0:91e:9d18:6a61 with SMTP id
 6a1803df08f44-921349d1bc2mr71972656d6.5.1795202587723; 
 Fri, 20 Nov 2026 11:23:07 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:23:07 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:27 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-24-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=2407;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=DGCS8sHKbE0ydhRdFa/l/CpSkKJ0kw9IB4FL0j4IV0s=;
 b=8PrY4Q2TCerTDXx1xT/KPmERjntn9DohDB2LIhybJVLtjqCElFlkzbOakWH4z1Y0oa95843TW
 kwL7eAZUUWYBUOPzIzLLP6j5t7sA3asiEw4U7Zjkw7dTRULRDvjzG5v
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=eOCGH3p1 c=1 sm=1 tr=0 ts=6b009e1d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=eDvTf86EaZyvr6gzFvIA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX8zegxY6M7lQZ
 RDs3Chwpb9KXPKpJYyNMurtWTAZ2ZaBGv9P27uLC2hClZwmz97cqvAI9Dtfd6jLiEtv9a8CHKg0
 fncK7RbpWDi3EssP8uevSjlFuouYIKQIOXCDzcpbtivVB88iOw3YK8sSPe7krAgH0Ba9ELsHGgc
 0lk+mKsnKzILG+uwDcDSFte6GDwX7jHRwarSrPU8efxNo0kjGkbXn7HtENByvHH3cVOEE8DLdJe
 wYtwvZqAkmcu5FTNiDwn9Hx1GJP3aHknwCeyBDuOGz/GMjqzWp2DVKh6rCrRkoFMXbADBWGrSZ2
 1WPgaTGfAOPQZ7BeSq2O5mehVOUhu6Ns1IaoOIkh3D01P0aDgHGdJFKRKsW49NgYy1MN2N4VfM0
 e54aq6edI+WeqhKMBpfzGT/yDO/0YAnRH8qDIN4IU9x37JDkIgKS97zIUbWn9humbo/1WGNurW7
 a/PGXfbRj4f2MqFwv7A==
X-Proofpoint-ORIG-GUID: 7sR7xaoEOTK6oxcEYpzZ7Qo9YJ4V3mMw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX9aBaVjb2nM71
 aWwDK+dDgS/YjIaZalSMEj7VOFApNjLZzH0C6NNACMpGSLfCGC6tTfYB8/7hM1lhlgmpYxzExXr
 Zd7u4MH3sCxod0TtcSLUQuq/gD0HQg1hxGGkI8q6o6ExHfSgfWg7
X-Proofpoint-GUID: 7sR7xaoEOTK6oxcEYpzZ7Qo9YJ4V3mMw
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 malwarescore=0 bulkscore=10 lowpriorityscore=10
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCZ-0000000018b-09XI
Subject: [f2fs-dev] [PATCH 24/28] f2fs: convert the cluster writeback and
 dirty helpers to rfolios
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Tal Zussman <tz2294@columbia.edu>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

cancel_cluster_writeback(), set_cluster_dirty(),
dirty_partial_compressed_cluster(), and f2fs_compress_write_end_io() get
the cluster folios with page_folio() on rpages. Read rfolios instead,
which holds the same pointers. This saves five hidden calls to
compound_head().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index db5f11689140..e7a0f66b7a89 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1169,7 +1169,7 @@ static void cancel_cluster_writeback(struct compress_ctx *cc,
 
 	/* Cancel writeback and stay locked. */
 	for (i = 0; i < nr_folios; i++) {
-		struct folio *folio = page_folio(cc->rpages[i]);
+		struct folio *folio = cc->rfolios[i];
 		unsigned int last_blk_in_folio =
 			((i + 1) << F2FS_LOG_BLKS_PER_PAGE(sbi)) - 1;
 
@@ -1196,11 +1196,10 @@ static void set_cluster_dirty(struct compress_ctx *cc)
 	int i;
 
 	for (i = 0; i < nr_folios; i++) {
-		struct folio *folio;
+		struct folio *folio = cc->rfolios[i];
 
-		if (!cc->rpages[i])
+		if (!folio)
 			continue;
-		folio = page_folio(cc->rpages[i]);
 		/*
 		 * The whole cluster is rewritten. This also attaches a folio
 		 * state to a multi-block folio before it is dirtied.
@@ -1658,10 +1657,9 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio,
 	page_array_free(sbi, cic->cpages, cic->nr_cpages);
 
 	for (i = 0; i < cic->nr_rpages; i++) {
-		struct folio *rfolio;
+		struct folio *rfolio = cic->rfolios[i];
 
-		WARN_ON(!cic->rpages[i]);
-		rfolio = page_folio(cic->rpages[i]);
+		WARN_ON(!rfolio);
 		folio_clear_f2fs_gcing(rfolio);
 		folio_end_writeback(rfolio);
 	}
@@ -1782,12 +1780,12 @@ static void dirty_partial_compressed_cluster(struct compress_ctx *cc)
 	if (cc->nr_rpages != nr_folios || f2fs_cluster_is_full(cc))
 		return;
 	for (i = 0; i < nr_folios; i++)
-		if (!folio_test_uptodate(page_folio(cc->rpages[i])))
+		if (!folio_test_uptodate(cc->rfolios[i]))
 			return;
 	if (f2fs_compressed_blocks(cc) <= 0)
 		return;
 	for (i = 0; i < nr_folios; i++) {
-		struct folio *folio = page_folio(cc->rpages[i]);
+		struct folio *folio = cc->rfolios[i];
 
 		/* A folio without a folio state is dirty as a whole. */
 		if (f2fs_folio_has_ffs(folio))

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
