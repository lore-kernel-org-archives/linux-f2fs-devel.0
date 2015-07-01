From: nick <xerofoify@gmail.com>
Subject: Re: [PATCH] f2fs:Make the function check_dnode have a
 return type of bool
Date: Tue, 30 Jun 2015 20:56:17 -0400
Message-ID: <55933AB1.1050002@gmail.com>
References: <1435608421-5951-1-git-send-email-xerofoify@gmail.com>
	<20150701005037.GA1496@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xerofoify@gmail.com>) id 1ZA6K9-0003Dz-Qs
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Jul 2015 00:56:25 +0000
Received: from mail-ig0-f174.google.com ([209.85.213.174])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZA6K9-0003lm-2u
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Jul 2015 00:56:25 +0000
Received: by igblr2 with SMTP id lr2so87213354igb.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 30 Jun 2015 17:56:20 -0700 (PDT)
In-Reply-To: <20150701005037.GA1496@jaegeuk-mac02.mot.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net



On 2015-06-30 08:50 PM, Jaegeuk Kim wrote:
> Hi,
> 
> On Mon, Jun 29, 2015 at 04:07:01PM -0400, Nicholas Krause wrote:
>> This makes the function check_dnode have a return type of bool
>> due to this particular function only ever returning either one
>> or zero as its return value.
>>
>> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
>> ---
>>  fs/f2fs/gc.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index e1e7361..ebd4c6c 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -487,7 +487,7 @@ block_t start_bidx_of_node(unsigned int node_ofs, struct f2fs_inode_info *fi)
>>  	return bidx * ADDRS_PER_BLOCK + ADDRS_PER_INODE(fi);
>>  }
>>  
>> -static int check_dnode(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>> +static bool check_dnode(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> 
> Then, what about bool is_data_alive() ?
> 
> Thanks,
> 
There is no function of this name in my searching with either lxr or cscope.
Either my tools aren't finding it or the function you are requesting I make
bool has been removed.
Nick

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
