From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH 2/2] f2fs: avoid move encrypted block in
 BG_GC if it has been in memory
Date: Tue, 14 Mar 2017 09:37:25 +0800
Message-ID: <4807ae60-da77-f502-f3a2-d5c4fe25f853@huawei.com>
References: <20170310095047.14540-1-heyunlei@huawei.com>
	<20170310095047.14540-2-heyunlei@huawei.com>
	<20170313183005.GB41055@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cnbPN-0007zd-Mp
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Mar 2017 01:37:53 +0000
Received: from [45.249.212.191] (helo=dggrg05-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cnbPL-0002p7-V1
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Mar 2017 01:37:53 +0000
In-Reply-To: <20170313183005.GB41055@jaegeuk.local>
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
Cc: linux-f2fs-devel@lists.sourceforge.net


Hi Jaegeuk,
On 2017/3/14 2:30, Jaegeuk Kim wrote:
> On 03/10, Yunlei He wrote:
>> If an encrypted block has been read to memory, we just dirty it
>> and return directly.
>>
>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>> ---
>>  fs/f2fs/gc.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 418fd98..ca94518 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -564,7 +564,7 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>  }
>>
>>  static void move_encrypted_block(struct inode *inode, block_t bidx,
>> -							unsigned int segno, int off)
>> +					int gc_type, unsigned int segno, int off)
>>  {
>>  	struct f2fs_io_info fio = {
>>  		.sbi = F2FS_I_SB(inode),
>> @@ -607,6 +607,12 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
>>  	 */
>>  	f2fs_wait_on_page_writeback(page, DATA, true);
>>
>> +	if (gc_type == BG_GC && PageUptodate(page) &&
>> +				fscrypt_has_encryption_key(inode)) {
>
> Why do we need the encryption key?

Here I am afraid some cases dirty encrypted pages have no authority to write back.

Thanks.
>
> Thanks,
>
>> +		set_page_dirty(page);
>> +		goto put_out;
>> +	}
>> +
>>  	get_node_info(fio.sbi, dn.nid, &ni);
>>  	set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
>>
>> @@ -827,7 +833,8 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>  			start_bidx = start_bidx_of_node(nofs, inode)
>>  								+ ofs_in_node;
>>  			if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
>> -				move_encrypted_block(inode, start_bidx, segno, off);
>> +				move_encrypted_block(inode, start_bidx,
>> +								gc_type, segno, off);
>>  			else
>>  				move_data_page(inode, start_bidx, gc_type, segno, off);
>>
>> --
>> 2.10.1
>>
>>
>> ------------------------------------------------------------------------------
>> Announcing the Oxford Dictionaries API! The API offers world-renowned
>> dictionary content that is easy and intuitive to access. Sign up for an
>> account today to start using our lexical data to power your apps and
>> projects. Get started today and enter our developer competition.
>> http://sdm.link/oxford
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>
> .
>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
