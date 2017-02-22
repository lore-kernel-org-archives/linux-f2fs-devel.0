From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 09/10] f2fs: avoid needless checkpoint in
 f2fs_trim_fs
Date: Wed, 22 Feb 2017 15:23:44 +0800
Message-ID: <42d767ad-f87e-3090-14a0-a1848e8556c2@huawei.com>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
	<20161230185117.3832-9-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cgRHI-00031a-96
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Feb 2017 07:23:56 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cgRHH-0002Qz-DE
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Feb 2017 07:23:56 +0000
In-Reply-To: <20161230185117.3832-9-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/12/31 2:51, Jaegeuk Kim wrote:
> The f2fs_trim_fs() doesn't need to do checkpoint if there are newly allocated
> data blocks only which didn't change the critical checkpoint data such as nat
> and sit entries.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
