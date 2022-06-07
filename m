Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4D8C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Jun 2022 06:14:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nySTb-0000fr-MV; Tue, 07 Jun 2022 06:14:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <lkp@intel.com>)
 id 1nySTZ-0000fW-NS; Tue, 07 Jun 2022 06:14:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=khFVcW3MLS7SoJTErp0Ezt99EakPVeB/RbJxON0w64M=; b=HlQvtK+cFBntBzjLdCLQGcjBxI
 0xoR+BsZryZJeNzOhjvbTzbv58685n7DDB7j2nc8g2uuKCWL60VSprcmv9PqekG5KMxmAjMvk15u8
 eyzaPcVAsKi/DDJ6EkdgdD9+m57UJhAx5m5QCy0xi8LKXvcfpR2PLWyYoufynMUVy9ho=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=khFVcW3MLS7SoJTErp0Ezt99EakPVeB/RbJxON0w64M=; b=SpLCh2w2Lzg1plNvaJ8Vj4R6U+
 dIQZ5qmvHoFMOHIVPW+n9oNzm9Y0EDw3Qo8TddugzGogpCHV9dviObbt9dM9od+Mjj/wPqFi7/Pfe
 OtUkArWABd+35YoV2UnhLj1SRMHjG0bbeB+UOJYM6nGMLEFbGK7f/5Mt96a4RdcaztKg=;
Received: from mga04.intel.com ([192.55.52.120])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nySTT-00040I-N9; Tue, 07 Jun 2022 06:14:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654582437; x=1686118437;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=pViZck3K1Rq0vF4B9iREn005L3q1DYrrwNaeY+v9f0c=;
 b=CoQj212bzAQzaS+UKcHxu4AMVL08qh0+1OijVYzYvV2bmUN1c3Pbcvbt
 TT+aq4W9J/pOr2HAOf1f0cyzIcQqo3udSQtsRim75z/tKcg6cEIAMqYd9
 tj141QUSdQ47reW4jZiDhYZ93fEj9LigoIRqlzSgTkiZFN8TrUeZgUuii
 P0+N+arRz5wg62WI3cIZ9UJgbxAvVllrdcbcGRUNVqAceLLF+3VmCQeMR
 vNsL/84cjsJsbqlJqaUs7qP69e7rV48so21+QweI+rbFuZ8rTly77y/iG
 EUR9E89YbNnzcStfrxfEaab5P5s5jD1BJibxlLnaYIBaQgGDqG77nZLTs w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="275483831"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; d="scan'208";a="275483831"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2022 23:13:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; d="scan'208";a="614746862"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
 by orsmga001.jf.intel.com with ESMTP; 06 Jun 2022 23:13:44 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nySTI-000DQ5-17;
 Tue, 07 Jun 2022 06:13:44 +0000
Date: Tue, 7 Jun 2022 14:13:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org
Message-ID: <202206071414.41wGG8fp-lkp@intel.com>
References: <20220606204050.2625949-15-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220606204050.2625949-15-willy@infradead.org>
X-Headers-End: 1nySTT-00040I-N9
Subject: Re: [f2fs-dev] [PATCH 14/20] hugetlb: Convert to migrate_folio
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
Cc: linux-aio@kvack.org, linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
 kbuild-all@lists.01.org, linux-ntfs-dev@lists.sourceforge.net,
 linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
 linux-ext4@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi "Matthew,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19-rc1 next-20220607]
[cannot apply to jaegeuk-f2fs/dev-test trondmy-nfs/linux-next kdave/for-next xfs-linux/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/Convert-aops-migratepage-to-aops-migrate_folio/20220607-044509
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git f2906aa863381afb0015a9eb7fefad885d4e5a56
config: ia64-randconfig-r015-20220605 (https://download.01.org/0day-ci/archive/20220607/202206071414.41wGG8fp-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b038962c9c8c2ab77c71dfba24356ce24bd7a242
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/Convert-aops-migratepage-to-aops-migrate_folio/20220607-044509
        git checkout b038962c9c8c2ab77c71dfba24356ce24bd7a242
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash fs/hugetlbfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/hugetlbfs/inode.c: In function 'hugetlbfs_migrate_folio':
>> fs/hugetlbfs/inode.c:990:17: error: implicit declaration of function 'folio_migrate_copy' [-Werror=implicit-function-declaration]
     990 |                 folio_migrate_copy(dst, src);
         |                 ^~~~~~~~~~~~~~~~~~
>> fs/hugetlbfs/inode.c:992:17: error: implicit declaration of function 'folio_migrate_flags'; did you mean 'folio_mapping_flags'? [-Werror=implicit-function-declaration]
     992 |                 folio_migrate_flags(dst, src);
         |                 ^~~~~~~~~~~~~~~~~~~
         |                 folio_mapping_flags
   cc1: some warnings being treated as errors


vim +/folio_migrate_copy +990 fs/hugetlbfs/inode.c

   972	
   973	static int hugetlbfs_migrate_folio(struct address_space *mapping,
   974					struct folio *dst, struct folio *src,
   975					enum migrate_mode mode)
   976	{
   977		int rc;
   978	
   979		rc = migrate_huge_page_move_mapping(mapping, dst, src);
   980		if (rc != MIGRATEPAGE_SUCCESS)
   981			return rc;
   982	
   983		if (hugetlb_page_subpool(&src->page)) {
   984			hugetlb_set_page_subpool(&dst->page,
   985						hugetlb_page_subpool(&src->page));
   986			hugetlb_set_page_subpool(&src->page, NULL);
   987		}
   988	
   989		if (mode != MIGRATE_SYNC_NO_COPY)
 > 990			folio_migrate_copy(dst, src);
   991		else
 > 992			folio_migrate_flags(dst, src);
   993	
   994		return MIGRATEPAGE_SUCCESS;
   995	}
   996	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
